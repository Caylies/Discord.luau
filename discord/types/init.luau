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

const Components = require("@self/components")
const Interactions = require("@self/interactions")
const Requests = require("@self/requests")
const Utils = require("@self/utils")

export type Embed = Components.Embed
export type Component = Components.Component
export type UnfurledMediaItem = Components.UnfurledMediaItem
export type SeparatorSpacing = Components.SeparatorSpacing
export type Separator = Components.Separator
export type TextDisplay = Components.TextDisplay
export type File = Components.File
export type Container = Components.Container
export type MessageSendInterface = Interactions.MessageSendInterface
export type WebhookExecutionInterface = Interactions.WebhookExecutionInterface
export type WebhookBody = Interactions.WebhookBody
export type WebhookURL = Interactions.WebhookURL
export type Serializable<T = { any }> = Requests.Serializable<T>
export type Serialize<Data> = Requests.Serialize<Data>
export type Select<Case1, Case2, Condition> = Utils.Select<Case1, Case2, Condition>

return nil
