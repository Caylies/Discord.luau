--[=[
The MIT License (MIT)

Copyright (c) 2026-present Cayla

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
]=]

export type Serializable<T = { any }> = {
    __serialize: (any) -> Serialize<T>
}

--[[
    Serializes all types in a table included nested tables.
    If a table has a `__serialize()` function, that function's return type will be used instead.

    @param Data type -- The data you want to serialize.
    @return type -- A serialized version of the type.
]]
export type function Serialize(Data: type): type
    const function Merge(...: type): type
        const Arguments = { ... }

        local Merged = types.newtable()

        for _, Argument in Arguments do
            if not Argument:is("table") then
                error(`Expected 'table', got '{Argument.tag}'`, 2)
            end

            for Key, Property in Argument:properties() do
                if Merged:readproperty(Key) then
                    error(`Duplicate key '{Key}' found`, 2)
                end

                Merged:setreadproperty(Key, Property.read)
            end
        end

        return Merged
    end

    const function SerializeTable(Table: type): type
        if Table:is("union") then
            Table = Merge(table.unpack(Table:components()))
        end

        if not Table:is("table") then
            error(`Expected 'table', got '{Data.tag}'`, 3)
        end

        local NewTable = types.newtable()

        for Key, Value in Table:properties() do
            const StringKey = tostring(Key:value())

            local ReadValue = Value.read
            local NewName = types.singleton(StringKey)

            if StringKey:sub(1, #"__") ~= "__" then
                NewName = types.singleton(StringKey:gsub("(%u)", "_%1"):gsub("^_", ""):lower())
            end

            if not ReadValue then
                NewTable:setreadproperty(NewName)
                continue
            end

            if ReadValue:is("table") then
                local Values: type? = ReadValue

                for InnerKey, Property in ReadValue:properties() do
                    local ReadProperty = Property.read

                    if InnerKey:value() ~= "__serialize" or not ReadProperty or not ReadProperty:is("function") then
                        continue
                    end

                    ReadProperty = ReadProperty :: type

                    const Head = ReadProperty:returns().head

                    if not Head then
                        continue
                    end

                    Values = Head[1]
                    break
                end

                Values = Values :: type

                NewTable:setreadproperty(NewName, SerializeTable(Values))
                continue
            end

            if ReadValue:is("union") then
                local NewComponents = {}

                for _, Component in ReadValue:components() do
                    local ComponentValue = Component

                    if ComponentValue:is("integer") then
                        ComponentValue = types.number
                    end

                    table.insert(NewComponents, ComponentValue)
                end

                ReadValue = types.unionof(table.unpack(NewComponents))
            end

            if ReadValue:is("integer") then
                NewTable:setreadproperty(NewName, types.number)
                continue
            end

            NewTable:setreadproperty(NewName, ReadValue)
        end

        return NewTable
    end

    return SerializeTable(Data)
end

return nil
