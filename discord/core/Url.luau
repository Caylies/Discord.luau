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

const Url = {}
Url.__index = Url

type function Default(Type: type, Default: type): type
    if Type:is("unknown") then
        return Default
    end

    return Type
end

export type Url<Queries = { [string]: any }> = setmetatable<{
    Raw: string,
    Queries: Queries,

    read new: (Raw: string) -> Url<Queries>,
    read AddQuery: <T>(self: Url<Queries>, Name: T & keyof<Queries>, Value: index<Queries, T>) -> (),
    read Get: (self: Url<Queries>) -> string,
}, typeof(Url)>

--[[
    Creates a new Url.

    @param Raw string -- The URL you want to store.
    @return Url -- A new Url instance.
]]
function Url.new<Queries>(Raw: string): Url<Default<Queries, { [string]: any }>>
    const self = setmetatable({}, Url) :: Url<Queries>

    self.Raw = Raw
    self.Queries = {}

    return self
end

--[[
    Adds a query to the URL.

    @method AddQuery
    @within Url

    @param Name string -- The name of the query.
    @param Value any -- The value of the query.
]]
function Url.AddQuery(self: Url, Name: string, Value: any): ()
    self.Queries[Name] = Value
end

--[[
    Returns the URL with its queries.

    @method Get
    @within Url

    @return string -- The full URL.
]]
function Url.Get(self: Url): string
    local Suffix = ""

    for Key, Value in self.Queries do
        Suffix ..= `?{Key}={Value}`
    end

    return self.Raw .. Suffix
end

return Url
