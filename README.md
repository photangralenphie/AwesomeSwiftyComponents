# AwesomeSwiftyComponents

Reusable components, extensions, ViewModifier, Styles and other Swift/SwiftUI stuff I use(d) in my projects.

**Feel free to use, but:**
* Expect breaking changes. 
* Bugs are guaranteed.
* Nothing has been tested on watchOS, tvOS and visonOS. 

## Components: 
* **[CreditManager](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/creditmanager):** to easily display credits for open source libraries.
* **[InlineColorPicker](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/inlinecolorpicker):** Customisable, works best in Forms. Support for saving with AppStorage.

<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/ColorSchemeSwitcher@3x.png" width="300">

* **[ColorSchemeSwitcher](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/colorschemeswitcher):** For switching between dark, light and system appearance - works best in Forms.

<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/InlineColorPicker@3x.png" width="300">
<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/InlineColorPickerIcon@3x.png" width="300">
<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/InlineColorPickerDescriptionIcon@3x.png" width="300">

* **[ListFooter](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/listfooter):** A footer for lists (duh!).

<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/ListFooter@3x.png" width="300">

* **[MovingColoredBackground](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/movingcoloredbackground):**
* **[TintEmoji](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/tintedemoji):** A view that takes an Emoji and applies Color.accentColor to it.

<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/TintedEmojis@3x.png" width="300">

* **[Emoji-Label](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swiftui/label/init(_:emoji:tinted:)):** Label overload (`Label(\_ text: LocalizedStringKey, emoji: String, tinted: Bool?)`) which creates an Label from a text and an Emoji.

<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/LabelWithEmoji@3x.png" width="300">

## Styles: 
* **Button:**
    * **iOSBorderedForMacOS()**: style mimicking the bordered ButtonStyle on iOS just for macOS.
    * **iOSBorderedProminentForMacOS()**: style mimicking the bordered prominent ButtonStyle on iOS just for macOS
* **Label:**
    * **[.centeredImage()](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swiftui/labelstyle/centeredimage(tinticon:))**: Style that vertically centers the icon.
    * **[.spaceAdaptable()](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swiftui/labelstyle/spaceadaptable(horizontalsizeclass:))**: Style that shows the icon and text in a regular horizontalSizeClass and the icon only in a compact horizontalSizeClass.

## Modifiers:
* **[.listGlassCell()](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swiftuicore/view/listglasscell(_:in:))**: switches the background of a list cell to liquid glass.
* **[.safeAreaView()](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swiftuicore/view/safeareaview(edge:alignment:spacing:content:))**: combines **safeAreaInset()** on iOS 18 and below and **safeAreaBar()** from iOS26 

## Others:
* [sheet in app browser](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swiftuicore/view/useinappsafari(_:)) (iOS 15-18) (deprecated use WebView from iOS 26 on).
* [array support for AppStorage](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swift/array/init(rawvalue:))
* [bool binding for optional data](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swiftuicore/binding/isnotnil()).
* luminance value for [CGColor](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/coregraphics/cgcolor/luminance) and [Color](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swiftuicore/color/luminance)
* more that, either doesn't work correctly right now, or I can't be bothered to write down.

## [Documentation](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/)

## Licence:
MIT Licence
