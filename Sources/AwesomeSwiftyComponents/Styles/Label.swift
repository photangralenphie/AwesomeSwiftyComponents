//
//  Label.swift
//  EasyChecklist
//
//  Created by Jonas Helmer on 31.05.24.
//

import SwiftUI

// MARK: - CenteredImage
/// A label style that vertically centers the icon next to the title.
///
/// Use this style to keep icons visually aligned with text in list rows or forms.
///
/// Example:
/// ```swift
/// Label("Settings", systemImage: "gear")
///     .labelStyle(.centeredImage(tintIcon: true))
/// ```
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct CenteredImageLabelStyle: LabelStyle {
	/// Whether to apply the accent color to the icon.
	public let tintIcon: Bool
	
    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
			if #available(iOS 15.0, *) {
				if tintIcon {
					configuration.icon
						.frame(width: 25)
						.foregroundStyle(Color.accentColor)
				} else {
					configuration.icon
						.frame(width: 25)
				}
			} else {
				if tintIcon {
					configuration.icon
						.frame(width: 25)
						.foregroundColor(Color.accentColor)
				} else {
					configuration.icon
						.frame(width: 25)
				}
			}
            configuration.title
                .padding(.leading, 5)
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension LabelStyle where Self == CenteredImageLabelStyle {

	/// A label style that vertically centers the icon. (tintIcon: if the icon should be displayed in the accent color)
	public static func centeredImage(tintIcon: Bool = false) -> CenteredImageLabelStyle {
		return CenteredImageLabelStyle(tintIcon: tintIcon)
	}
	
	/// A label style that vertically centers the icon.
	public static var centeredImage: CenteredImageLabelStyle {
		.init(tintIcon: false)
	}
}


// MARK: - SpaceAdaptable
/// A label style that adapts to horizontal size class.
///
/// In compact width, only the icon is shown. In regular width, both icon and title are shown.
///
/// Example:
/// ```swift
/// @Environment(\.horizontalSizeClass) private var hSize
/// 
/// Label("Bookmarks", systemImage: "bookmark")
///     .labelStyle(.spaceAdaptable(horizontalSizeClass: hSize))
/// ```
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
public struct DefaultSpaceAdaptableLabelStyle: LabelStyle {
	
	/// The current horizontal size class used to decide whether to show the title.
	public let horizontalSizeClass: UserInterfaceSizeClass?
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.icon
		if horizontalSizeClass == .regular {
			configuration.title
		}
	}
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
extension LabelStyle where Self == DefaultSpaceAdaptableLabelStyle {

	/// A label style that shows the icon and text in a regular horizontalSizeClass and the icon only in a compact horizontalSizeClass.
	public static func spaceAdaptable(horizontalSizeClass: UserInterfaceSizeClass?) -> DefaultSpaceAdaptableLabelStyle {
		return DefaultSpaceAdaptableLabelStyle(horizontalSizeClass: horizontalSizeClass)
	}
}

