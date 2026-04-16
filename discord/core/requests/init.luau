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

const Requests = {}

const json = require("@std/json")

const Types = require("../types")
const Strings = require("./utils/strings")

type Serialize<T> = Types.Serialize<T>
type Serializable<T = { any }> = Types.Serializable<T>
type JsonifySelect<T, R> = Types.Select<Serialize<T>, string, R>

--[[
    Serializes all values in a table, including nested values.
    If a table has a `__serialize()` function, that function's return value will be used instead.

    @param Jsonify R & (true | false) -- Whether `json.serialize(...)` will wrapped around the return value.
    @param Data T & {} -- The data you want to serialize.
    @return JsonifySelect<T, R> -- A serialized version of the data.
]]
function Requests.Serialize<R, T>(Jsonify: R & (true | false), Data: T & {}): JsonifySelect<T, R>
    local Serialized: { [any]: any } = {}

    for Key, Value in Data :: any do
        const IsNumber = typeof(Key) == "number"

        Key = Strings.PascalToSnake(tostring(Key))

        if typeof(Value) == "table" then
            local NewValue = nil

            if Value["__serialize"] ~= nil then
                Value = Value :: Serializable
                NewValue = Requests.Serialize(false, Value:__serialize())
            else
                NewValue = Requests.Serialize(false, Value :: {})
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

    if Jsonify then
        return json.serialize(Serialized) :: JsonifySelect<T, R>
    end

    return Serialized :: JsonifySelect<T, R>
end

return Requests
