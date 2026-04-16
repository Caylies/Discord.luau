--[[
    Example: webhooks/sending-embeds.

    Connects to a Discord webhook and sends a message with embeds.
]]

const Discord = require("../../discord")

const Components = Discord.Components

const Embed = Components.Embed

const Webhook = Discord.Webhook.FromUrlAsync("ENTER_WEBHOOK_URL_HERE")

const function ExampleEmbed(): Discord.Embed
    const NewEmbed = Embed {
        Title = "Example Embed",
        Description = "This is an example embed for Discord.luau!",
        Color = Discord.Color.Blue(),
        Url = "https://github.com/Caylies/Discord.luau"
    }

    NewEmbed:AddField {
        Name = "Field #1",
        Value = "This is the first embed field",
        Inline = true,
    }

    NewEmbed:AddField {
        Name = "Field #2",
        Value = "This is the second embed field",
        Inline = true,
    }

    NewEmbed:SetAuthor {
        Name = "Example Author",
        Url = "https://github.com/Caylies/Discord.luau",
        IconUrl = "https://upload.wikimedia.org/wikipedia/en/thumb/9/98/Discord_logo.svg/960px-Discord_logo.svg.png"
    }

    return NewEmbed
end

Webhook:SendAsync {
    Username = "Example Webhook",
    Embeds = {
        ExampleEmbed(),
    },
}

Webhook:Disconnect()
