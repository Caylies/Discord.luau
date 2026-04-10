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

export type Component = {
    read Type: integer,
    read id: integer?,
}

export type UnfurledMediaItem = {
    read url: string,
}

export type SeparatorSpacing = "Small" | "Large"

export type Separator = Component & {
    read Spacing: SeparatorSpacing,
    read Divider: boolean,
}

export type TextDisplay = Component & {
    read Content: string,
}

export type File = Component & {
    read Name: string,
    read File: UnfurledMediaItem,
    read Spoiler: boolean,
}

export type Container = Component & {
    read Components: { Component },
    read AccentColor: any,
    read Spoiler: boolean,
}

return nil
