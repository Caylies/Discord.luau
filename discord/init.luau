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

const Color = require("@self/color")
const Components = require("@self/components")
const Webhook = require("@self/webhook")
const Internal = require("@self/internal")

export type Color = Color.Color
export type Embed = Components.Embed
export type Component = Components.Component
export type SeparatorSpacing = Components.SeparatorSpacing
export type Separator = Components.Separator
export type TextDisplay = Components.TextDisplay
export type Container = Components.Container
export type Webhook = Webhook.Webhook

return {
    Color = Color,
    Components = Components,
    Webhook = Webhook,
    Internal = Internal,
}
