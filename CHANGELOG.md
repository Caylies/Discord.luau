# Changelog

Discord.luau changes will be documented in this file.

## [Unreleased]

### Added

- Added a new Color module based on Roblox's Color3 class for components and embeds.
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
- Added a new Component module for building message components.
  - Added the `Container` component.
  - Added the `TextDisplay` component.
  - Added the `Separator` component.
  - Added the `File` component.
- Exported types to their respective modules.
  - Color:
    - Exported the `Color` class type.
  - Components:
    - Exported the `Component` class type.
    - Exported the `SeparatorSpacing` string literal type.
    - Exported the `Separator` class type.
    - Exported the `TextDisplay` class type.
    - Exported the `File` class type.
    - Exported the `Container` class type.
  - Webhook:
    - Exported the `Webhook` class type.
- Semi-proper error handling has been implemented for `Webhook.FromURL(...)`.
- `Webhook.FromURL(...)` now accepts a `Components` parameter.
- Message flags have been added.
  - Added the `IS_COMPONENTS_V2` message flag.

### Fixed

- Fixed an issue where `Serializer.Serialize` wouldn't serialize tables correctly.
- Fixed an issue where `json.serialize` would fail due to `Serializer.Serialize` not converting `integer` into `number`.

### Changed

- `Webhook.Connect(...)` has been changed to `Webhook.FromURL(...)` for clarity.
- `Webhook:Delete(...)` has been changed to `Webhook:DeleteAsync(...)` to specify it's a yielding method.
- `Webhook.WebhookURL` has been changed to `Webhook.WebhookUrl` for consistency.
