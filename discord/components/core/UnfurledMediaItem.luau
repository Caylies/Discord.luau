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

const UnfurledMediaItem = {}
UnfurledMediaItem.__index = UnfurledMediaItem

const stringext = require("@std/stringext")

export type UnfurledMediaItem = setmetatable<{
    Url: string,
}, typeof(UnfurledMediaItem)>

--[[
    Creates a new UnfurledMediaItem.

    @param Url string -- The piece of media you want to store via URL.
    @return UnfurledMediaItem -- A new UnfurledMediaItem instance.
]]
function UnfurledMediaItem.new(Url: string): UnfurledMediaItem
    if not stringext.hasPrefix(Url, "attachment://") then
        error("Invalid attachment url passed", 3)
    end

    const self = setmetatable({}, UnfurledMediaItem) :: UnfurledMediaItem

    self.Url = Url

    return self
end

function UnfurledMediaItem.__serialize(self: UnfurledMediaItem)
    return { url = self.Url }
end


return UnfurledMediaItem
