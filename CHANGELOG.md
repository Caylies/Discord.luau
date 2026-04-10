# Changelog

Discord.luau changes will be documented in this file.

## [Unreleased]

### Added

- Added a new `Color` module based on Roblox's Color3 class for components and embeds.
  - Added 12 default color presets:
    - Added `Color.Default()`
    - Added `Color.Blue()`
    - Added `Color.Red()`
    - Added `Color.Green()`
    - Added `Color.Orange()`
    - Added `Color.Purple()`
    - Added `Color.Gold()`
    - Added `Color.Black()`
    - Added `Color.White()`
    - Added `Color.Blurple()`
    - Added `Color.Fuchsia()`
    - Added `Color.Greyple()`
  - Added `Color.new(...)`
  - Added `Color.FromRGB(...)`
  - Added `Color.FromHex(...)`
  - Added `Color.FromHSV(...)`
  - Added `Color.FromDecimal(...)`
  - Added `Color:ToDecimal()`
- Added a new `Components` module for building message components.
  - Added the `Embed` legacy component.
  - Added the `Container` component.
  - Added the `TextDisplay` component.
  - Added the `Separator` component.
  - Added the `File` component.
- Exported types to Discord.luau's source module.
  - Exported the `Color` class type.
  - Exported the `Embed` class type.
  - Exported the `Component` class type.
  - Exported the `SeparatorSpacing` string literal type.
  - Exported the `Separator` class type.
  - Exported the `TextDisplay` class type.
  - Exported the `File` class type.
  - Exported the `Container` class type.
  - Exported the `Webhook` class type.
- Added a `Verbose` property to `Logger` to control whether or not messages logged with `Logger:Debug(...)` will print.
- Added `Logger:Debug(...)` for verbose logging.
  - Messages logged with `Logger:Debug(...)` will only appear if the `Verbose` property for that Logger is set to `true`.
- Added an `env` file that holds global Discord.luau configuration.
  - Added a `Verbose` variable to control debug logging globally.
- Improved the logging module's structure.
- Improved error handling for `Webhook.FromURL(...)`, `Webhook:SendAsync(...)`, and `Webhook:DeleteAsync(...)`.
- `Webhook.FromURL(...)` now accepts a `Components` parameter for rendering components.
- `Webhook.FromURL(...)` now accepts an `Embeds` parameter for rendering embeds.
- Added the `IS_COMPONENTS_V2` message flag.

### Fixed

- Fixed an issue where `Serializer.Serialize` wouldn't serialize tables correctly.
- Fixed an issue where `json.serialize` would fail due to `Serializer.Serialize` not converting `integer` into `number`.

### Changed

- `Webhook.Connect(...)` has been changed to `Webhook.FromURL(...)` for clarity.
- `Webhook:Delete(...)` has been changed to `Webhook:DeleteAsync(...)` to specify it's a yielding method.
- `Webhook.WebhookURL` has been changed to `Webhook.WebhookUrl` for consistency.
