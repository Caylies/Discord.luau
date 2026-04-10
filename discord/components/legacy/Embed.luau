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

const Embed = {}
Embed.__index = Embed

const Color = require("../../color")

type Color = Color.Color

type EmbedField = {
    name: string,
    value: string,
    inline: boolean?
}

type Parameters = {
    Title: string?,
    Description: string?,
    Color: Color?,
    Url: string?
}

export type Embed = setmetatable<{
    Title: string?,
    Description: string?,
    Url: string?,
    Color: Color?,
    Fields: { EmbedField }?,
}, typeof(Embed)>

--[[
    Creates a new Embed component.

    @param Title string? -- The embed's title.
    @param Description string? -- The embed's description.
    @param Color string? -- The embed's color.
    @param Url string? -- The embed's title url.
    @return Embed -- The created Embed component.
]]
function Embed.new(Parameters: Parameters): Embed
    const self = setmetatable({}, Embed) :: Embed

    self.Title = Parameters.Title
    self.Description = Parameters.Description
    self.Color = Parameters.Color
    self.Url = Parameters.Url

    return self
end

--[[
    Adds a new field to an embed.

    @param Name string -- The field's name.
    @param Value string -- The field's value.
    @param Inline boolean? -- Whether or not the field will be inlined.
]]
function Embed.AddField(self: Embed, Name: string, Value: string, Inline: boolean?)
    error("Not implemented yet", 2)
end

function Embed.__serialize(self: Embed)
    local SerializedColor = self.Color

    if SerializedColor then
        SerializedColor = (self.Color :: Color):__serialize()
    end

    return {
        title = self.Title,
        description = self.Description,
        Color = SerializedColor,
        Url = self.Url,
    }
end

return Embed.new
