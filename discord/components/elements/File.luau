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

const File = {
    IS_COMPONENT = true,
}
File.__index = File

const UnfurledMediaItem = require("../core/UnfurledMediaItem")

type UnfurledMediaItem = UnfurledMediaItem.UnfurledMediaItem

type Parameters = {
    read Url: string,
    read Name: string?,
    read Spoiler: boolean?
}

export type File = setmetatable<{
    Name: string?,
    File: UnfurledMediaItem,
    Spoiler: boolean?,
}, typeof(File)>

--[[
    Creates a new File component.

    @param url string -- The file's url.
    @return File -- The created File component.
]]
function File.new(Parameters: Parameters): File
    const self = setmetatable({}, File) :: File

    self.File = UnfurledMediaItem.new(Parameters.Url)
    self.Name = Parameters.Name
    self.Spoiler = Parameters.Spoiler

    return self
end

function File.__serialize(self: File)
    return {
        type = 13i,
        name = self.Name,
        file = self.File:__serialize(),
        spoiler = self.Spoiler,
    }
end

return File.new
