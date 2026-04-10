--!strict

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

const Serializer = {}

const Types = require("../types/object")
const Strings = require("./utils/strings")

type Serialized<T> = Types.Serialized<T>

-- TODO: Move this function to `discord/core/requests`.
function Serializer.Serialize<T>(Data: T & {}): T
    local Serialized: { [any]: any } = {}

    for Key, Value in Data :: any do
        const IsNumber = typeof(Key) == "number"

        Key = Strings.PascalToSnake(tostring(Key))

        if typeof(Value) == "table" then
            local NewValue = nil

            if Value["__serialize"] then
                Value = Value :: Serialized<typeof(Value)>
                NewValue = Serializer.Serialize(Value:__serialize())
            else
                NewValue = Serializer.Serialize(Value)
            end

            if IsNumber then
                table.insert(Serialized, NewValue)
                continue
            end

            Serialized[Key] = NewValue
            continue
        end
        
        if typeof(Value) == "integer" then -- The Lute JSON library doesn't support integers yet
            Serialized[Key] = integer.tonumber(Value)
            continue
        end

        Serialized[Key] = Value
    end

    return Serialized
end

return Serializer
