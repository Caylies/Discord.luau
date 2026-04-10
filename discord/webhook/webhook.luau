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

--[[
    Webhook class used for connecting to and executing Discord webhooks.

    @class Webhook
]]
const Webhook = {}
Webhook.__index = Webhook

const json = require("@std/json")
const net = require("@lute/net/client")

const Logging = require("../core/logging")
const Serializer = require("../core/serializer")
const Dictionaries = require("../core/utils/dictionaries")
const InteractionTypes = require("../types/interactions")

const Logger = Logging.GetLogger("Webhook")

type WebhookExecutionInterface = InteractionTypes.WebhookExecutionInterface

export type Webhook = setmetatable<{
    read WebhookURL: string
}, typeof(Webhook)>

--[[
    Connects to a Discord webhook via its URL.

    @param WebhookURL string -- The webhook's URL.
    @return Webhook -- The connected webhook.
]]
function Webhook.Connect(WebhookURL: string): Webhook
    return setmetatable({WebhookURL = WebhookURL}, Webhook)
end

--[[
    Executes a webhook with the given parameters.

    @yields
    @method SendAsync
    @within Webhook

    @param Parameters WebhookExecutionInterface -- The execution parameters.
]]
function Webhook.SendAsync(self: Webhook, Parameters: WebhookExecutionInterface): ()
    if Dictionaries.Length(Parameters) == 0i then
        Logger:Critical("InvalidData: Attempt to pass through an empty table")
    end

    const Body = json.serialize(Serializer.Serialize(Parameters), true)

    const response = net.request(self.WebhookURL, {
        method = "POST",
        body = Body,
        headers = {
            ["Content-Type"] = "application/json"
        }
    })

    print(response.status, response.ok)
end

--[[
    Deletes the current webhook.

    @param Reason string? -- The reason for deleting the webhook.
]]
function Webhook.Delete(self: Webhook, Reason: string?): ()
    local headers = {
        ["Content-Type"] = "application/json"
    }

    if Reason then
        headers["X-Audit-Log-Reason"] = Reason
    end

    const response = net.request(self.WebhookURL, {
        method = "DELETE",
        headers = headers
    })

    print(response.status, response.ok)

    self:Disconnect()
end

--[[
    Disconnect the current webhook instance.
]]
function Webhook.Disconnect(self: Webhook): ()
    table.clear(self)
    setmetatable(self, nil)
end

return Webhook
