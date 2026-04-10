--!strict

--[[
    Example: sending-to-a-webhook-with-components.

    Connects to a Discord webhook and sends a message with components.
]]

const Discord = require("../../discord")

const Components = Discord.Components

const Container = Components.Container
const TextDisplay = Components.TextDisplay
const Separator = Components.Separator
-- const File = Components.File

const Webhook = Discord.Webhook.FromURL("ENTER_WEBHOOK_URL_HERE")

const function ErrorContainer(Name: string): Discord.Container
    const NewContainer = Container {
        AccentColor = Discord.Color.Red(),

        TextDisplay(`### Example Webhook Error: {Name}`),
        Separator(),
        TextDisplay("We could not process your request, sorry!"),
    }
    
    return NewContainer :: Discord.Container
end

Webhook:SendAsync {
    Username = "Example Webhook",
    Components = {
        ErrorContainer("404")
    }
}

Webhook:Disconnect()
