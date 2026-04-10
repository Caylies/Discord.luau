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

--[[
    A simple color module inspired by Roblox's Color3 module.

    @class Color
]]
const Color = {}
Color.__index = Color

const tableext = require("@std/tableext")

const function Wrap(Decimal: integer): () -> Color
    return function(): Color
        return Color.FromDecimal(Decimal)
    end
end

const DEFAULT_COLORS = {
    Default = Wrap(0i),
    Blue = Wrap(15548997i),
    Red = Wrap(15548997i),
    Green = Wrap(5763719i),
    Orange = Wrap(15105570i),
    Purple = Wrap(10181046i),
    Gold = Wrap(15844367i),
    Black = Wrap(10070709i),
    White = Wrap(16777215i),
    Blurple = Wrap(5793266i),
    Fuchsia = Wrap(15418782i),
    Greyple = Wrap(10070709i),
}

export type Color = setmetatable<{
    R: number,
    G: number,
    B: number,
}, typeof(Color)>

--[[
    Returns a Color with the given red, green, and blue values.

    @param R number -- The red value of the color (0-1).
    @param G number -- The green value of the color (0-1).
    @param B number -- The blue value of the color (0-1).
    @return Color -- The new color.
]]
function Color.new(R: number, G: number, B: number): Color
	return setmetatable({ R = R, G = G, B = B }, Color)
end

--[[
    Returns a Color with the given decimal.

    @param Decimal integer -- The decimal value of the color.
    @return Color -- The new color.
]]
function Color.FromDecimal(Decimal: integer): Color
    const Mask = 0xFFi

    const R = integer.band(integer.rshift(Decimal, 16i), Mask)
    const G = integer.band(integer.rshift(Decimal, 8i), Mask)
    const B = integer.band(Decimal, Mask)

	return Color.FromRGB(integer.tonumber(R), integer.tonumber(G), integer.tonumber(B))
end

--[[
    Returns a Color from given components within the range of 0 to 255.

    @method FromRGB
    @within Color

    @param R number -- The red value of the color (0-255).
    @param G number -- The green value of the color (0-255).
    @param B number -- The blue value of the color (0-255).
    @return Color -- The new color.
]]
function Color.FromRGB(R: number, G: number, B: number): Color
	return Color.new(R / 255, G / 255, B / 255)
end

--[[
    Returns a Color from a given hex value.

    @method FromHex
    @within Color

    @param Hex string -- The hexadecimal string representing the color.
    @return Color -- The new color.
]]
function Color.FromHex(Hex: string): Color
	Hex = Hex:gsub("#", "")

    const Numbers = {
        tonumber(Hex:sub(1, 2), 16),
        tonumber(Hex:sub(3, 4), 16),
        tonumber(Hex:sub(5, 6), 16)
    } :: { number }

	return Color.FromRGB(table.unpack(Numbers))
end

--[[
    Returns a Color from the given hue, saturation, and value components.

    @method FromHSV
    @within Color

    @param H number -- The hue of the color (0-1).
    @param S number -- The saturation of the color (0-1).
    @param V number -- The value of the color (0-1).
    @return Color -- The new color.
]]
function Color.FromHSV(H: number, S: number, V: number): Color
    local HueSector = math.floor(H * 6)
    local Fractional = (H * 6) - HueSector

    local ValueScaledDown = V * (1 - S)
    local ValueFadeDown = V * (1 - Fractional * S)
    local ValueFadeUp = V * (1 - (1 - Fractional) * S)
    local SectorIndex = HueSector % 6

    local Arguments = { V, ValueScaledDown, ValueFadeDown }

    if SectorIndex == 0 then
        Arguments = { V, ValueFadeUp, ValueScaledDown }
    elseif SectorIndex == 1 then
        Arguments = { ValueFadeDown, V, ValueScaledDown }
    elseif SectorIndex == 2 then
        Arguments = { ValueScaledDown, V, ValueFadeUp }
    elseif SectorIndex == 3 then
        Arguments = { ValueScaledDown, ValueFadeDown, V }
    elseif SectorIndex == 4 then
        Arguments = { ValueFadeUp, ValueScaledDown, V }
    end

    return Color.new(table.unpack(Arguments))
end

--[[
    Converts the Color to a decimal integer.

    @method ToDecimal
    @within Color

    @return integer -- The decimal representation of the color.
]]
function Color.ToDecimal(self: Color): integer
    local R = integer.create(math.floor(self.R * 255))
    local G = integer.create(math.floor(self.G * 255))
    local B = integer.create(math.floor(self.B * 255))

    return integer.bor(integer.lshift(R, 16i), integer.lshift(G, 8i), B)
end

function Color.__serialize(self: Color): integer
    return self:ToDecimal()
end

return tableext.combine(Color, DEFAULT_COLORS) :: typeof(Color) & typeof(DEFAULT_COLORS)
