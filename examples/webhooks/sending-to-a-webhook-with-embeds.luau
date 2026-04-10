--!strict

--[[
    Example: sending-to-a-webhook-with-embeds.

    Connects to a Discord webhook and sends a message with embeds.
]]

const Discord = require("../../discord")

const Components = Discord.Components

const Embed = Components.Embed

const Webhook = Discord.Webhook.FromURL("ENTER_WEBHOOK_URL_HERE")

const NewEmbed = Embed {
    Title = "Hi! #1",
    Description = "Wow, so cool!",
    Color = Discord.Color.Green(),
    Url = "https://google.com"
}

--[[
NewEmbed:AddField {
    Name = "Testing",
    Value = "Hi!",
    Inline = true,
}
]]

Webhook:SendAsync {
    Username = "Example Webhook",
    Embeds = { NewEmbed },
}

Webhook:Disconnect()
