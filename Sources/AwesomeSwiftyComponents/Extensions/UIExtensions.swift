#if(os(iOS))
import UIKit
/// A collection of unrelated static functions, that can modify the appearance of your app
public struct UIExtensions {
    
    /// Sets the NavigationBar font.
    /// - Parameter fontDesign: The font to use.
    public static func setNavigationBarFont(fontDesign: UIFontDescriptor.SystemDesign)  {
        let largeTitleDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(fontDesign)!
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)!
        let smallTitleDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
            .withDesign(fontDesign)!
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)!

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.largeTitleTextAttributes = [
            .font: UIFont(descriptor: largeTitleDescriptor, size: 0)
        ]
        standardAppearance.titleTextAttributes = [
            .font: UIFont(descriptor: smallTitleDescriptor, size: 0)
        ]
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.largeTitleTextAttributes = [
            .font: UIFont(descriptor: largeTitleDescriptor, size: 0)
        ]
        scrollEdgeAppearance.titleTextAttributes = [
            .font: UIFont(descriptor: smallTitleDescriptor, size: 0)
        ]

        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
    }
}
#endif
