--!strict

--[[
    Example: sending-to-a-webhook.

    Connects to a Discord webhook and sends a message.
]]

const Discord = require("../../discord")
const Webhook = Discord.Webhook.FromURL("ENTER_WEBHOOK_URL_HERE")

Webhook:SendAsync {
    Username = "Example Webhook",
    Content = "Hello World!"
}

Webhook:Disconnect()
