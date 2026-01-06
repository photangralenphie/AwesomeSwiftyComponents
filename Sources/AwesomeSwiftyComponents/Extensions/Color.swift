//
//  Color.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 31.12.25.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - COLOR
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
extension Color {
	/// The ``CoreGraphics/CGColor`` of a ``SwiftUICore/Color``
	@available(iOS 14.0, macOS 11.0, tvOS 14.0, visionOS 1.0, *)
	@available(watchOS, unavailable)
	public var CgColor: CGColor {
		#if canImport(UIKit)
		UIColor(self).resolvedColor(with: UITraitCollection.current).cgColor
		#elseif canImport(AppKit)
		NSColor(self).cgColor
		#else
		CgColor(red: 0, green: 0, blue: 0, alpha: 1)
		#endif
	}
	
	
	@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
	fileprivate static let randomColorOptions: [Color] = [.blue, .brown, .cyan, .green, indigo, .mint, .orange, .purple, .pink, .red, .teal, .yellow]
	/// gives back a random SwiftUI ``SwiftUICore/Color`` out of the following options
	/// ```swift
	/// [.blue, .brown, .cyan, .green, indigo, .mint, .orange, .purple, .pink, .red, .teal, .yellow]
	/// ```
	@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
	public static var random: Color {
		Color.randomColorOptions.randomElement()!
	}
}

// MARK: - CGCOLOR
extension CGColor {
	/// The luminance (brightness) of a ``CoreGraphics/CGColor`` (0 == dark, 1 == bright).
	/// Can be used to check if a foreground color should be white or black in relation to a background.
	public var luminance: CGFloat? {
		guard let components = self.components else { return nil }

		let r = components[0]
		let g = components[1]
		let b = components[2]

		// Relative luminance (sRGB)
		return 0.2126 * r + 0.7152 * g + 0.0722 * b
	}
}

// MARK: - AvailableColors
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension AvailableColors {
	/// <#Description#>
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
	
	/// <#Description#>
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
