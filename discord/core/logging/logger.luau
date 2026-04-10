--!strict

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

const Logger = {}
Logger.__index = Logger

const TYPE_COLORS: { [string]: string } = {
	ERROR = "\27[31m",
	WARNING = "\27[33m",
	INFO = "\27[32m",
	CRITICAL = "\27[35m",
}

const RESET_COLOR: string = "\27[0m"

export type Logger = setmetatable<{
	read Name: string,
}, typeof(Logger)>

--[[
    Creates a new logger with the specified name.

    @param Name string -- The name of the logger.
    @return Logger -- A new logger with the specified name.
]]
function Logger.new(Name: string): Logger
	return setmetatable({ Name = Name }, Logger)
end

--[[
    Formats a log message with colors and formatting.

    @param Message string -- The message to format.
    @param Type keyof<typeof(TYPE_COLORS)> -- The type of the log message.
    @return string -- The formatted log message.
]]
function Logger._FormatMessage(self: Logger, Message: string, Type: keyof<typeof(TYPE_COLORS)>): string
	const Timestamp: string = os.date("%Y-%m-%d %H:%M:%S")
	const Color: string = TYPE_COLORS[Type] or RESET_COLOR

	return `\27[90m[{Timestamp}]\27[0m \27[36m[{self.Name}]\27[0m {Color}{Type}{RESET_COLOR}: {Message}`
end

--[[
    Logs an info message.

    @param Message string -- The message to log.
]]
function Logger.Info(self: Logger, Message: string): ()
	print(self:_FormatMessage(Message, "INFO"))
end

--[[
    Logs a warning message.

    @param Message string -- The message to log.
]]
function Logger.Warn(self: Logger, Message: string): ()
	print(self:_FormatMessage(Message, "WARNING"))
end

--[[
    Logs an error message.

    @param Message string -- The message to log.
]]
function Logger.Error(self: Logger, Message: string): ()
	print(self:_FormatMessage(Message, "ERROR"))
end

--[[
    Logs a critical message and terminates execution.

    @param Message string -- The message to log.
]]
function Logger.Critical(self: Logger, Message: string): never
	error(self:_FormatMessage(Message, "CRITICAL"), 0)
end

return Logger
