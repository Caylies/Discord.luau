--[[
    Example: webhooks/getting-info.

    Connects to a Discord webhook and prints its information.
]]

const Discord = require("../../discord")
Discord.Internal.SetVerbose(true)

const Webhook = Discord.Webhook.FromUrlAsync("ENTER_WEBHOOK_URL_HERE")

print(Webhook.Avatar)
print(Webhook.Name)
