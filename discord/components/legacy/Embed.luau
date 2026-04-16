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
    Embed class for legacy Discord message components.

    @class Embed
]]
const Embed = {}
Embed.__index = Embed

const Color = require("../../color")

type Color = Color.Color

type EmbedAuthor = {
    name: string,
    url: string?,
    icon_url: string?,
}

type EmbedField = {
    name: string,
    value: string,
    inline: boolean?,
}

type Parameters = {
    Title: string?,
    Description: string?,
    Color: Color?,
    Url: string?,
}

type AuthorParameters = {
    Name: string,
    Url: string?,
    IconUrl: string?,
}

type FieldParameters = {
    Name: string,
    Value: string,
    Inline: boolean?,
}

type function Negate(Type: type): type
    return types.negationof(Type)
end

export type Embed = setmetatable<{
    Title: string?,
    Description: string?,
    Url: string?,
    Color: Color?,
    Fields: { EmbedField }?,
    Author: EmbedAuthor?,
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

    @method AddField
    @within Embed

    @param Name string -- The field's name.
    @param Value string -- The field's value.
    @param Inline boolean? -- Whether or not the field will be inlined.
]]
function Embed.AddField(self: Embed, Parameters: FieldParameters)
    if not self.Fields then
        self.Fields = {}
    end

    const Field: EmbedField = {
        name = Parameters.Name,
        value = Parameters.Value,
        inline = Parameters.Inline,
    }

    table.insert(self.Fields :: typeof(self.Fields) & Negate<nil>, Field)
end

--[[
    Sets the embed's author.

    @method SetAuthor
    @within Embed

    @param Name string -- The author's name.
    @param Url string? -- The author's URL.
    @param IconUrl string? -- The author's icon URL.
]]
function Embed.SetAuthor(self: Embed, Parameters: AuthorParameters)
    self.Author = {
        name = Parameters.Name,
        url = Parameters.Url,
        icon_url = Parameters.IconUrl
    }
end

function Embed.__serialize(self: Embed)
    local SerializedColor = self.Color

    if SerializedColor then
        SerializedColor = (self.Color :: Color):__serialize()
    end

    return {
        title = self.Title,
        description = self.Description,
        color = SerializedColor,
        url = self.Url,
        fields = self.Fields,
        author = self.Author,
    }
end

return Embed.new
