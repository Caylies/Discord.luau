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

const Logging = require("@core/logging")
const Requests = require("@core/requests")
const Dictionaries = require("@core/utils/dictionaries")
const MessageFlags = require("@core/flags/message")
const Url = require("@core/Url")
const Types = require("@types")

const Logger = Logging.GetLogger("Discord.Webhook")

type WebhookExecutionInterface = Types.WebhookExecutionInterface
type WebhookBody = Types.WebhookBody
type WebhookURL = Types.WebhookURL

export type Webhook = setmetatable<{
    read ApplicationID: integer?,
    read Avatar: string?,
    read ChannelID: integer,
    read GuildID: integer,
    read ID: integer,
    read Name: string,
    read Token: string,
    read Url: string
}, typeof(Webhook)>

function ProperNil<T>(Field: T): T | nil
    return if Field ~= json.null then Field else nil
end

--[[
    Connects to a Discord webhook via its URL.

    @yields

    @param WebhookUrl string -- The webhook's URL.
    @return Webhook -- The connected webhook.
]]
function Webhook.FromUrlAsync(WebhookUrl: string): Webhook
    Logger:Debug(`Sending request via 'GET' to webhook with URL: '{WebhookUrl}'`)

    const Response = net.request(WebhookUrl, {
        method = "GET",
        headers = {
            ["Content-Type"] = "application/json"
        }
    })

    if not Response.ok then
        Logger:Critical(`HTTPError: Discord Request Status Code {Response.status}`)
    end

    Logger:Debug(`Request successful (Status Code {Response.status})`)

    const Body = json.deserialize(Response.body) :: WebhookBody
    const ApplicationID = ProperNil(Body.application_id)
    const Avatar = ProperNil(Body.avatar)

    Logger:Debug(`Constructing new Webhook class with: {json.serialize(Body :: any, true)}`)

    return setmetatable({
        ApplicationID = if ApplicationID then integer.create(ApplicationID) else nil,
        Avatar = if Avatar then `https://cdn.discordapp.com/avatars/{Body.id}/{Avatar}.png` else nil,
        ChannelID = integer.create(Body.channel_id),
        GuildID = integer.create(Body.guild_id),
        ID = integer.create(Body.id),
        Name = Body.name,
        Token = Body.token,
        Url = Body.url,
    }, Webhook) :: Webhook
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
        Logger:Critical("ImproperBody: Attempt to pass through an empty table")
    end

    if Parameters.Components then
        const ImproperBodyMessage = (
            "ImproperBody: The '%s' parameter can't be used when using the 'IS_COMPONENTS_V2' message flag"
        )

        if Parameters.Content then
            Logger:Critical(ImproperBodyMessage.format("content"))
        end

        if Parameters.Embeds then
            Logger:Critical(ImproperBodyMessage.format("embeds"))
        end
    end

    local WebhookUrl = Url.new<<WebhookURL>>(self.Url)
    local RawBody = Requests.Serialize(false, Parameters)

    if Parameters.Components then
        WebhookUrl:AddQuery("with_components", true)

        RawBody = RawBody :: typeof(RawBody) & { flags: number }
        RawBody["flags"] = MessageFlags.IS_COMPONENTS_V2
    end

    const Body = json.serialize(RawBody :: any, true)

    Logger:Debug(`Sending request via 'POST' through webhook with body: {Body}`)

    const Response = net.request(WebhookUrl:Get(), {
        method = "POST",
        body = Body,
        headers = {
            ["Content-Type"] = "application/json"
        }
    })

    if not Response.ok then
        Logger:Critical(`HTTPError: Discord Request Status Code {Response.status}`)
    end

    Logger:Debug(`Request successful (Status Code {Response.status})`)
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

    Logger:Debug("Sending request via 'DELETE' through webhook")

    const Response = net.request(self.Url, {
        method = "DELETE",
        headers = headers
    })

    if not Response.ok then
        Logger:Critical(`HTTPError: Discord Request Status Code {Response.status}`)
    end

    Logger:Debug(`Request successful (Status Code {Response.status})`)
    self:Disconnect()
end

--[[
    Destroys the current webhook class instance.
]]
function Webhook.Disconnect(self: Webhook): ()
    Logger:Debug("Clearing active webhook instance")

    table.clear(self)
    setmetatable(self, nil)
end

return Webhook
