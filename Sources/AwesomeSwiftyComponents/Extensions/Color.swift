//
//  Color.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 31.12.25.
//

import SwiftUI

extension Color {
	public var CgColor: CGColor {
		UIColor(self).cgColor
	}
}

extension CGColor {
	public var luminance: CGFloat? {
		guard let components = self.components else { return nil }

		let r = components[0]
		let g = components[1]
		let b = components[2]

		// Relative luminance (sRGB)
		return 0.2126 * r + 0.7152 * g + 0.0722 * b
	}
}
