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

const Container = {
    IS_COMPONENT = true,
}
Container.__index = Container

const Color = require("../../color")
const ComponentTypes = require("../../types/components")
const ObjectTypes = require("../../types/object")

type Component = ComponentTypes.Component
type Color = Color.Color
type Serialized<T> = ObjectTypes.Serialized<T>

export type Container = setmetatable<{
    AccentColor: Color?,
    Spoiler: boolean?,
    Components: { Component },
}, typeof(Container)>

--[[
    Creates a new Container component.

    @param AccentColor Color? -- The accent color for the container.
    @param Spoiler boolean? -- Whether the container will be marked as a spoiler.
    @return Container -- The created Container component.
]]
function Container.new(Parameters: { [any]: any }): Container
    const self = setmetatable({}, Container) :: Container

    self.Components = {}
    self.AccentColor = Parameters.AccentColor
    self.Spoiler = Parameters.Spoiler

    for Key, Component in Parameters do
        if typeof(Component) ~= "table" or not Component["IS_COMPONENT"] then
            continue
        end

        table.insert(self.Components, Component)
    end

    return self
end

function Container.__serialize(self: Container)
    local SerializedComponents: { Serialized<Component> } = {}

    for _, Component in self.Components do
        Component = Component :: Serialized<typeof(Component)>
        table.insert(SerializedComponents, Component:__serialize())
    end

    const SerializedColor = if self.AccentColor then self.AccentColor:__serialize() else nil

    return {
        type = 17i,
        components = SerializedComponents,
        accent_color = SerializedColor,
        spoiler = self.Spoiler,
    }
end

return Container.new
