# ``AwesomeSwiftyComponents``

Reusable SwiftUI components, styles, and helpers for Apple platforms.

@Metadata {
  @TitleHeading("AwesomeSwiftyComponents")
}

## Overview

`AwesomeSwiftyComponents` provides focused UI building blocks you can drop into app screens, settings flows, and utility views.
The package includes:

- Presentation components for layouts, pickers, labels, and list footers.
- Ready-to-use system button variants and style helpers.
- Credit/license UI to surface attribution cleanly.
- Utility types and extensions for common app concerns.

## Highlights

### Layout and Visual Components

- ``AxisAdaptiveStack``: A stack that adapts its axis based on the current horizontal size class.
- ``MovingColoredBackground``: An animated, gradient-style background that adds subtle motion to your UI.
@Row {
	@Column(size: 9) {
		Light Background:
		@Video(source: "MovingBackgroundLight.mov")
	}
	@Column(size: 10) {
		Dark Background:		
		@Video(source: "MovingBackgroundDark.mov")
	}
}

- ``TintedEmoji``: Displays an emoji with a tinted background for quick visual accents.
![TintedEmoji example](TintedEmojis)

- ``ListFooter``: A reusable footer view for lists, typically used for secondary or informational text.
![ListFooter example](ListFooter)

- ``InlineColorPicker``: A compact inline color picker that can optionally show icons and descriptions. (Use with ``AvailableColors`` & ``ColorOptions``)

@TabNavigator {
	@Tab("Default") {
		![Default InlineColorPicker](InlineColorPicker)
	}
	
	@Tab("With Icon") {
		![Default InlineColorPicker with Icon](InlineColorPickerIcon)
	}
	
	@Tab("Expanded with Icon and Description") {
		![Expanded InlineColorPicker with Icon and Description](InlineColorPickerDescriptionIcon)
	}
}

- ``ColorSchemeSwitcher``: A control for switching between light, dark, and system appearance modes. (Use with ``PreferredColorScheme``)
![ColorSchemeSwitcher example](ColorSchemeSwitcher)


### Credits and Licenses

- ``CreditManager``: Presents attribution and license information in an in-app credits interface. (Use with ``Licence``)
@Row {
	@Column {
		![CreditManager example](CreditManager)
	}
	@Column {
		![CreditManager license detail example](CreditManagerLicence)
	}
}

- ``LinkedCreditManager``: A credit manager variant optimized for linked or navigable credit entries. (Use with ``Licence``)
![CreditManager license detail example](CreditManagerLicence)

- ``LicenceLink``: Renders a tappable link to a license source or detail view.
- ``LicenceView``: Displays full license text or metadata for a selected license.


### Buttons and Label Styles

- ``CancelButton``: A standardized cancel action button with platform-appropriate styling.
- ``ConfirmButton``: A standardized confirm action button with platform-appropriate styling.
- ``DestructiveButton``: A standardized destructive/delete action button with platform-appropriate styling.
- ``CloseButton``: A standardized close action button with platform-appropriate styling.
- ``CenteredImageLabelStyle``: A label style that centers the icon and text layout.
- ``DefaultSpaceAdaptableLabelStyle``: A label style that adapts spacing based on available room.
- ``SwiftUICore/View/glassOrBorderedButtonStyle()``: Uses glass button styling on newer OS versions and bordered style on older ones.
- ``SwiftUICore/View/glassOrBorderedProminentButtonStyle()``: Uses prominent glass button styling on newer OS versions and bordered prominent style on older ones.

### Utilities

- ``UIExtensions/setNavigationBarFont(fontDesign:)``: Configures the app-wide `UINavigationBar` title fonts using a chosen system font design.
- ``ObservableAppStorage(key:variableName:type:defaultValue:)``: Macro that generates an observable `UserDefaults`-backed property when key and property name differ.
- ``ObservableAppStorage(_:type:defaultValue:)``: Macro that generates an observable `UserDefaults`-backed property when key and property name are the same.
- ``Swift/Array/init(rawValue:)``: Decodes a Codable array from its JSON `String` representation.
- ``Swift/Array/rawValue``: Encodes a Codable array as JSON text for string-backed persistence.
- ``SwiftUICore/Binding/isNotNil()``: Converts an optional binding into a `Binding<Bool>` that reflects whether a value exists.
- ``SwiftUICore/Color/CgColor``: Resolves a SwiftUI `Color` to a platform `CGColor`.
- ``SwiftUICore/Color/random``: Returns a random color from a curated system-color palette.
- ``SwiftUICore/Color/luminance``: Computes perceived brightness of a SwiftUI color.
- ``CoreGraphics/CGColor/luminance``: Computes perceived brightness of a `CGColor`.
- ``Foundation/Data/id``: Conforms `Data` to `Identifiable` using itself as a stable identifier.
- ``SwiftUICore/View/safeAreaView(edge:alignment:spacing:content:)``: Inserts custom content into the safe area with compatibility handling across OS versions.
- ``SwiftUICore/View/listGlassCell(_:in:)``: Applies a glass row background style suitable for list/form cells.
- ``SwiftUICore/View/useInAppSafari(_:)``: Intercepts `openURL` links and presents them in-app when enabled.
- ``SwiftUICore/Glass/bar(for:)``: Returns a glass style tuned for bar-like surfaces based on current color scheme.
- ``MovingColoredBackgroundVm``: View-model object that drives the ``MovingColoredBackgroundVm``.
- ``AvailableColors``: Built-in palette options for ``InlineColorPicker``.
- ``ColorOptions``: Protocol used to define custom color option sets for ``InlineColorPicker``.
- ``PreferredColorScheme``: Enum describing the available appearance preferences for the ``ColorSchemeSwitcher``.
- ``Licence``: Represents supported license types used by the ``CreditManager``, ``LinkedCreditManager``, ``LicenceLink`` and ``LicenceLink``.
