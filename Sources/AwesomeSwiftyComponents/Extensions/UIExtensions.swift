#if !os(macOS)
import UIKit
#endif

/// A collection of unrelated static functions, that can modify the appearance of your app
public struct UIExtensions {
    
	#if !os(macOS)
    /// Sets the NavigationBar font.
    /// - Parameter fontDesign: The font to use.
	@available(iOS 15.0, *)
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

		// iOS 15+ uses scrollEdgeAppearance when content scrolls behind the nav bar
		navBar.scrollEdgeAppearance = appearance

		navBar.compactAppearance = appearance
		navBar.compactScrollEdgeAppearance = appearance
    }
	#endif
}
