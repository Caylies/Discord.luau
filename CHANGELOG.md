# Changelog

Discord.luau changes will be documented in this file.

## [Unreleased]

### Added

- Added a new `Color` module based on Roblox's Color3 class for components and embeds.
  - Added 12 default color presets:
    - Added `Color.Default()`.
    - Added `Color.Blue()`.
    - Added `Color.Red()`.
    - Added `Color.Green()`.
    - Added `Color.Orange()`.
    - Added `Color.Purple()`.
    - Added `Color.Gold()`.
    - Added `Color.Black()`.
    - Added `Color.White()`.
    - Added `Color.Blurple()`.
    - Added `Color.Fuchsia()`.
    - Added `Color.Greyple()`.
  - Added `Color.new(...)`.
  - Added `Color.Random()`.
  - Added `Color.FromRGB(...)`.
  - Added `Color.FromHex(...)`.
  - Added `Color.FromHSV(...)`.
  - Added `Color.FromDecimal(...)`.
  - Added `Color:ToDecimal()`.
- Added a new `Components` module for building message components.
  - Added the `Embed` legacy component.
    - Added `Embed:AddField(...)` method for adding fields to embeds.
    - Added `Embed:SetAuthor(...)` method for setting an embed's author.
  - Added the `Container` component.
    - Added `Container:Add(...)` method for adding components to a container.
  - Added the `TextDisplay` component.
  - Added the `Separator` component.
- Added a new `Internal` module for configuring Discord.luau.
  - Added `Internal.Verbose` for verbose logging.
  - Added `Internal.SetVerbose(...)` to control whether logging will be verbose.
- Exported types to Discord.luau's source module.
  - Exported the `Color` class type.
  - Exported the `Embed` class type.
  - Exported the `Component` class type.
  - Exported the `SeparatorSpacing` string literal type.
  - Exported the `Separator` class type.
  - Exported the `TextDisplay` class type.
  - Exported the `Container` class type.
  - Exported the `Webhook` class type.
- Added more properties to the `Webhook` class.
  - Added `Webhook.ApplicationID` property.
  - Added `Webhook.Avatar` property.
  - Added `Webhook.ChannelID` property.
  - Added `Webhook.GuildID` property.
  - Added `Webhook.ID` property.
  - Added `Webhook.Name` property.
  - Added `Webhook.Token` property.
- Exported all types to the `type` module.
- Added a `Requests` core module for handling Discord API requests and data serialization.
- Added `Url` class for providing an OOP way of modifying and accessing URLs.
- Added `Logger:Debug(...)` for verbose logging.
  - Messages logged with `Logger:Debug(...)` will only appear if the `Verbose` property in the internal module is set to `true`.
- Improved the logging module's structure.
- Improved error handling for `Webhook.FromUrlAsync(...)`, `Webhook:SendAsync(...)`, and `Webhook:DeleteAsync(...)`.
- `Webhook.FromUrlAsync(...)` now accepts a `Components` parameter for rendering components.
- `Webhook.FromUrlAsync(...)` now accepts an `Embeds` parameter for rendering embeds.
- Added the `IS_COMPONENTS_V2` message flag.
- Added `.luaurc` for project-wide configuration.
  - Removed all references of `--!strict` in favor or `languageMode: "strict"`
  - Added `@root` alias to reference the project's root folder.
  - Added `@core` alias to reference `discord/core`.
  - Added `@utils` alias to reference `discord/core/utils`.
  - Added `@types` alias to reference `discord/types`.
  - Added `@color` alias to reference `discord/color`.
  - Added `@internal` alias to reference `discord/internal`.
  - Added various Lute aliases.

### Changed

- `Webhook.Connect(...)` has been changed to `Webhook.FromUrlAsync(...)` for clarity.
- `Webhook.FromUrlAsync(...)` now yields.
- `Webhook:Delete(...)` has been changed to `Webhook:DeleteAsync(...)` to specify it's a yielding method.
- `Webhook.WebhookURL` has been changed to `Webhook.Url` for consistency.
- `Serializer.Serialize(...)` has been moved to the request module in favor of `Requests.Serialize(...)` as the new solution offers far better type checking, automatic JSON serialization, and a more appropriate location.
- Various example file names have been shortened.
- Bumped Lute to v1.0.0.

### Fixed

- Fixed an issue where `Serializer.Serialize` wouldn't serialize tables correctly.
- Fixed an issue where `json.serialize` would fail due to `Serializer.Serialize` not converting `integer` into `number`.
- Fixed an issue where Lute libraries weren't being recognized and type-checked.
