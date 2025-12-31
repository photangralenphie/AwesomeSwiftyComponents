# Reusable components, extensions, ViewModifier, Styles and other Swift/SwiftUI stuff I use(d) in my projects.

**Feel free to use, but:**
* Expect breaking changes. 
* Bugs are guaranteed.

## Components: 
* **CreditManager:** to easily display credits for open source libraries.
* **InlineColorPicker:** Customisable, works best in Forms. Support for saving with AppStorage.
* **ColorScheme:** For switching between dark, light and system appearance - works best in Forms.
* **ListFooter:** A footer for lists (duh!).

## Styles: 
* **Button:**
    * **iOSBorderedForMacOS()**: style mimicking the bordered ButtonStyle on iOS just for macOS.
    * **iOSBorderedProminentForMacOS()**: style mimicking the bordered prominent ButtonStyle on iOS just for macOS
* **Label:**
    * **.centeredImage()**: Style that vertically centers the icon.
    * **.spaceAdaptable()**: Style that shows the icon and text in a regular horizontalSizeClass and the icon only in a compact horizontalSizeClass.

## Modifiers:
* **.listGlassCell()**: switches the background of a list cell to liquid glass.
* **.conditionalBackground()**: conditionally shows the provided background.
* **.safeAreaView()**: combines **safeAreaInset()** on iOS 18 and below and **safeAreaBar()** from iOS26 

## Others:
* sheet in app browser (iOS 15-18) (deprecated use WebView from iOS 26 on).
* array support for AppStorage.
* bool binding for optional data.
* luminance value for CGColor
* more that, either doesn't work correctly right now, or I can't be bothered to write down.

## No documentation yet - sorry :/
coming soon... (promise)

## Licence:
MIT Licence
