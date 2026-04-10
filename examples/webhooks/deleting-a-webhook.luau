--!strict

--[[
    Example: deleting-a-webhook.

    Connects to a Discord webhook and deletes it.
]]

const task = require("@lute/task")

const Discord = require("../../discord")
const Webhook = Discord.Webhook.Connect("https://discord.com/api/webhooks/1492001254295994539/6BHUMxXATifKhDZY-KVGtm9ErF8N40oVD45et-_b7VfqxLoMX25DgVF32pECUzl6ewQy")

task.wait(5)

Webhook:Delete("Optional reason for deleting the webhook")
