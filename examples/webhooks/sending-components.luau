--[[
    Example: webhooks/sending-components.

    Connects to a Discord webhook and sends a message with components.
]]

const Discord = require("../../discord")
Discord.Internal.SetVerbose(true)

const Components = Discord.Components

const Container = Components.Container
const TextDisplay = Components.TextDisplay
const Separator = Components.Separator

const Webhook = Discord.Webhook.FromUrlAsync("ENTER_WEBHOOK_URL_HERE")

const function ErrorContainer(Name: string): Discord.Container
    const NewContainer = Container {
        AccentColor = Discord.Color.Red(),

        TextDisplay(`### Example Webhook Error: {Name}`),
        Separator(),
        TextDisplay("We could not process your request, sorry!"),
    }

    NewContainer:Add(TextDisplay("Contact support to fix this!"), 2i)
    NewContainer:Add(TextDisplay("For additional information, read our error manual."))
    
    return NewContainer :: Discord.Container
end

Webhook:SendAsync {
    Username = "Example Webhook",
    Components = {
        ErrorContainer("404")
    },
}

Webhook:Disconnect()
