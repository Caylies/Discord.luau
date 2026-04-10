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
const MessageFlags = require("../core/flags/message")
const InteractionTypes = require("../types/interactions")

const Logger = Logging.GetLogger("Discord.webhook.webhook")

type WebhookExecutionInterface = InteractionTypes.WebhookExecutionInterface

export type Webhook = setmetatable<{
    read WebhookUrl: string
}, typeof(Webhook)>

--[[
    Connects to a Discord webhook via its URL.

    @param WebhookUrl string -- The webhook's URL.
    @return Webhook -- The connected webhook.
]]
function Webhook.FromURL(WebhookUrl: string): Webhook
    return setmetatable({WebhookUrl = WebhookUrl}, Webhook)
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

    if Parameters.Components and Parameters.Content then
        Logger:Critical(
            "InvalidData: The 'content' parameter can't be used when using the 'IS_COMPONENTS_V2' message flag"
        )       
    end

    local WebhookUrl = self.WebhookUrl
    local RawBody = Serializer.Serialize(Parameters) :: { [any]: any }

    if Parameters.Components then
        WebhookUrl ..= "?with_components=true"
        RawBody["flags"] = MessageFlags.IS_COMPONENTS_V2
    end

    const Body = json.serialize(RawBody, true)

    const Response = net.request(WebhookUrl, {
        method = "POST",
        body = Body,
        headers = {
            ["Content-Type"] = "application/json"
        }
    })

    if not Response.ok then
        Logger:Critical(`HTTPError: Discord Request Status {Response.status}`)
    end
end

--[[
    Deletes the current webhook.

    @yields
    @method DeleteAsync
    @within Webhook

    @param Reason string? -- The reason for deleting the webhook.
]]
function Webhook.DeleteAsync(self: Webhook, Reason: string?): ()
    local headers = {
        ["Content-Type"] = "application/json"
    }

    if Reason then
        headers["X-Audit-Log-Reason"] = Reason
    end

    const Response = net.request(self.WebhookUrl, {
        method = "DELETE",
        headers = headers
    })

    if not Response.ok then
        Logger:Critical(`HTTPError: Discord Request Status {Response.status}`)
    end

    self:Disconnect()
end

--[[
    Disconnects the current webhook instance.
]]
function Webhook.Disconnect(self: Webhook): ()
    table.clear(self)
    setmetatable(self, nil)
end

return Webhook
