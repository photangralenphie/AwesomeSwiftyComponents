# AwesomeSwiftyComponents

Reusable components, extensions, ViewModifier, Styles and other Swift/SwiftUI stuff I use(d) in my projects.

**Feel free to use, but:**
* Expect breaking changes. 
* Bugs are guaranteed.
* Nothing has been tested on watchOS, tvOS and visionOS. 

## Components

All Components automatically support light and dark modes.

### CreditManager
* To easily display credits for Open-Source libraries.
* [Documentation](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/creditmanager)

<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/CreditManager~dark@3x.png" width="300"> <img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/CreditManagerLicence~dark@3x.png" width="300">

* The CreditManger has variations and parts that can be used separately. See also:
   * [LinkedLicenceManager](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/linkedcreditmanager)
   * [LicenceLink](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/licencelink)
   * [LicenceView](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/licenceview)

### ColorSchemeSwitcher
* For switching between dark, light and system appearance - works best in Forms.
* [Documentation](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/colorschemeswitcher)
<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/ColorSchemeSwitcher~dark@3x.png" width="300">

### InlineColorPicker
* Customisable, works best in Forms. Support for saving with AppStorage.
* [Documentation](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/inlinecolorpicker)
<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/InlineColorPicker~dark@3x.png" width="300">
<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/InlineColorPickerIcon~dark@3x.png" width="300">
<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/InlineColorPickerDescriptionIcon~dark@3x.png" width="300">

### ListFooter
* A footer for lists (duh!).
* [Documentation](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/listfooter)
<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/ListFooter~dark@3x.png" width="300">

### MovingColoredBackground
* An slow moving animated colored background.
* [Documentation](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/movingcoloredbackground)
* Dark Appearance:

https://github.com/user-attachments/assets/8dc50870-3254-473f-8025-19da02acc874 

* Light Appearance:

https://github.com/user-attachments/assets/7388a911-db49-4eb8-849a-0511498d3594

### TintEmoji
* A view that takes an Emoji and applies Color.accentColor to it.
* [Documentation](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/tintedemoji) 
<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/TintedEmojis~dark@3x.png" width="300">

### Emoji-Label
* A new Label overload which creates an Label from a text and an Emoji.
* [Documentation](https://photangralenphie.github.io/AwesomeSwiftyComponents/documentation/awesomeswiftycomponents/swiftui/label/init(_:emoji:tinted:))
<img src="https://photangralenphie.github.io/AwesomeSwiftyComponents/images/awesomeswiftycomponents.AwesomeSwiftyComponents/LabelWithEmoji~dark@3x.png" width="300">

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
