--[[
    Example: webhooks/deleting.

    Connects to a Discord webhook and deletes it.
]]

const task = require("@lute/task")

const Discord = require("../../discord")
const Webhook = Discord.Webhook.FromUrlAsync("ENTER_WEBHOOK_URL_HERE")

task.wait(5)

Webhook:DeleteAsync("Optional reason for deleting the webhook")
