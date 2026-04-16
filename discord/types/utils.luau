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

--[[
    If `Condition` is true, the second type passed through will be returned, otherwise the first gets returned.

    @param Case1 type -- The type that will be returned if `Condition` is false.
    @param Case2 type -- The type that will be returned if `Condition` is true.
    @param Condition type -- A true or false singleton that will determine which type is chosen.
    @return type -- The returned type depending on the value of `Condition`.
]]
export type function Select(Case1: type, Case2: type, Condition: type): type
    if not Condition then
        error("Condition is missing or nil", 2)
    end

    if not Condition:is("singleton") then
        error(`Expected 'singleton', got '{Condition.tag}'`, 2)
    end

    const ConditionValue = Condition:value()

    if typeof(ConditionValue) ~= "boolean" then
        error(`Expected 'boolean', got '{typeof(ConditionValue)}'`, 2)
    end

    if not ConditionValue then
        return Case1
    end

    return Case2
end

return nil
