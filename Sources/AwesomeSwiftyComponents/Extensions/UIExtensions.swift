//
//  NavigationFontSetter.swift
//  Wizzard Locations
//
//  Created by Jonas Helmer on 20.11.24.
//

import UIKit

public struct UIExtensions {
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
