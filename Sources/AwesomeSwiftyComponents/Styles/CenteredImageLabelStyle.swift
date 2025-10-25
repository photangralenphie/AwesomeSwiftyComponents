//
//  CenteredImageLabelStyle.swift
//  EasyChecklist
//
//  Created by Jonas Helmer on 31.05.24.
//

import SwiftUI

@available(macOS 12, iOS 15, *)
public struct CenteredImageLabelStyle: LabelStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
			if #available(iOS 15.0, *) {
				configuration.icon
					.frame(width: 25)
					.foregroundStyle(Color.accentColor)
			} else {
				configuration.icon
					.frame(width: 25)
					.foregroundColor(Color.accentColor)
			}
            configuration.title
                .padding(.leading, 5)
        }
    }
}

@available(macOS 12.0,  iOS 15, *)
extension LabelStyle where Self == CenteredImageLabelStyle {

	/// A label style that vertically centers the icon.
	public static var centeredImage: CenteredImageLabelStyle { get { .init() }}
}
