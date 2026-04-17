--[[
    Example: webhooks/sending.

    Connects to a Discord webhook and sends a message.
]]

const Discord = require("../../discord")
Discord.Internal.SetVerbose(true)

const Webhook = Discord.Webhook.FromUrlAsync("ENTER_WEBHOOK_URL_HERE")

Webhook:SendAsync {
    Username = "Example Webhook",
    Content = "Hello World!"
}

Webhook:Disconnect()
