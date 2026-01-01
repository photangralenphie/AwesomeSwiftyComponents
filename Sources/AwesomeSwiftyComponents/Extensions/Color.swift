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

@available(iOS 17, *)
extension AvailableColors {
	public var adjacentColor1: Color {
		switch self {
			case .blue: return .cyan
			case .cyan: return .mint
			case .mint: return .green
			case .green: return .yellow
			case .yellow: return .orange
			case .orange: return .red
			case .red: return .purple
			case .purple: return .indigo
			case .indigo: return .blue
			case .primary: return .secondary
		}
	}
	
	public var adjacentColor2: Color {
		switch self {
			case .blue: return .indigo
			case .cyan: return .blue
			case .mint: return .cyan
			case .green: return .mint
			case .yellow: return .green
			case .orange: return .red
			case .red: return .orange
			case .purple: return .red
			case .indigo: return .purple
			case .primary: return .secondary
		}
	}
}
