#if canImport(UIKit)
import UIKit
/// A collection of unrelated static functions, that can modify the appearance of your app
public struct UIExtensions {
    
    /// Sets the NavigationBar font.
    /// - Parameter fontDesign: The font to use.
	@available(iOS 15.0, *)
	@available(macOS, unavailable)
	@available(tvOS, unavailable)
	@available(visionOS, unavailable)
	@available(watchOS, unavailable)
	public static func setNavigationBarFont(fontDesign: UIFontDescriptor.SystemDesign)  {
		let largeTitleBase = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
		let bodyBase = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)

		guard
			let largeTitleDesign = largeTitleBase.withDesign(fontDesign),
			let bodyDesign = bodyBase.withDesign(fontDesign),
			let largeTitleBold = largeTitleDesign.withSymbolicTraits(.traitBold),
			let bodyBold = bodyDesign.withSymbolicTraits(.traitBold)
		else {
			return
		}

		let largeTitleFont = UIFont(descriptor: largeTitleBold, size: 0)
		let smallTitleFont = UIFont(descriptor: bodyBold, size: 0)

		let appearance = UINavigationBarAppearance()
		appearance.configureWithDefaultBackground()
		appearance.titleTextAttributes = [
			.font: smallTitleFont
		]
		appearance.largeTitleTextAttributes = [
			.font: largeTitleFont
		]

		let navBar = UINavigationBar.appearance()
		navBar.standardAppearance = appearance

		navBar.compactAppearance = appearance
		navBar.compactScrollEdgeAppearance = appearance
    }
}
#endif
