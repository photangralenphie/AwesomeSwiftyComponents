//
//  Label.swift
//  EasyChecklist
//
//  Created by Jonas Helmer on 31.05.24.
//

import SwiftUI

// MARK: - CenteredImage
@available(macOS 12, iOS 15, *)
public struct CenteredImageLabelStyle: LabelStyle {
	let tintIcon: Bool
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

@available(macOS 12.0,  iOS 15, *)
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
public struct DefaultSpaceAdaptableLabelStyle: LabelStyle {
	
	public let horizontalSizeClass: UserInterfaceSizeClass?
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.icon
		if horizontalSizeClass == .regular {
			configuration.title
		}
	}
}

extension LabelStyle where Self == DefaultSpaceAdaptableLabelStyle {

	/// A label style that shows the icon and text in a regular horizontalSizeClass and the icon only in a compact horizontalSizeClass.
	public static func spaceAdaptable(horizontalSizeClass: UserInterfaceSizeClass?) -> DefaultSpaceAdaptableLabelStyle {
		return DefaultSpaceAdaptableLabelStyle(horizontalSizeClass: horizontalSizeClass)
	}
}
