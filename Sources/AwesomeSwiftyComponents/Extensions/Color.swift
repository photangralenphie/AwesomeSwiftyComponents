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
	/// Returns the CoreGraphics `CGColor` that best represents this SwiftUI `Color` on the current platform.
	///
	/// On iOS, this resolves dynamic colors (like semantic colors that vary with light/dark mode)
	/// against the current `UITraitCollection` before returning the underlying `CGColor`.
	///
	/// ### Example
	/// ```swift
	/// let fill = Color.accentColor
	/// let cg = fill.CgColor
	/// context.setFillColor(cg)
	/// context.fill(rect)
	/// ```
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
	
	
	/// Internal palette used by `Color.random`. Values are stable across platforms and OS versions.
	@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
	fileprivate static let randomColorOptions: [Color] = [.blue, .brown, .cyan, .green, indigo, .mint, .orange, .purple, .pink, .red, .teal, .yellow]
	/// Returns a random SwiftUI `Color` chosen from a curated set of vibrant system colors.
	///
	/// One of the following will be chosen at random.
	/// ```swift
	/// let colors: [Color] = [.blue, .brown, .cyan, .green, .indigo, .mint, .orange, .purple, .pink, .red, .teal, .yellow]
	/// ```
	///
	/// #### Example
	/// ```swift
	/// struct RandomSwatch: View {
	///     let color = Color.random
	///     var body: some View {
	///         Circle().fill(color)
	///     }
	/// }
	/// ```
	@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
	public static var random: Color {
		Color.randomColorOptions.randomElement()!
	}
	
	/// The perceived brightness of this `Color` in the sRGB color space (0 = dark, 1 = bright).
	///
	/// Use this to decide on a contrasting foreground color for legibility.
	/// Returns `nil` if a `CGColor` cannot be produced.
	///
	/// ### Example
	/// ```swift
	/// let bg = Color.blue
	/// let text: Color = (bg.luminance ?? 0) < 0.5 ? .white : .black
	/// ```
	/// Use ``CoreGraphics/CGColor/luminance`` to get the luminance of a `CGColor`
	@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
	public var luminance: CGFloat? { CgColor.luminance }
}

// MARK: - CGCOLOR
extension CGColor {
	/// The perceived brightness of this `CGColor` in the sRGB color space (0 = dark, 1 = bright).
	///
	/// Uses the standard relative luminance formula: `0.2126 * R + 0.7152 * G + 0.0722 * B`.
	/// Returns `nil` when color components are unavailable.
	///
	/// ### Example
	/// ```swift
	/// if let l = myCGColor.luminance, l < 0.5 {
	///     // Use a light foreground color
	/// }
	/// ```
	/// Use ``SwiftUICore/Color/luminance`` to get the luminance of a SwiftUI `Color`
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
/// Utilities for deriving related colors and high-contrast foregrounds from an `AvailableColors` base color.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension AvailableColors {
	/// The first adjacent color on the hue wheel for this base color.
	///
	/// ### Example
	/// ```swift
	/// let a1 = AvailableColors.blue.adjacentColor1 // .cyan
	/// ```
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
	
	/// The second adjacent color on the hue wheel for this base color.
	///
	/// ### Example
	/// ```swift
	/// let a2 = AvailableColors.blue.adjacentColor2 // .indigo
	/// ```
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
	
	/// A high-contrast foreground `Color` suitable for content displayed on this base color.
	///
	/// This chooses white text for dark backgrounds and black text for light backgrounds based on luminance.
	///
	/// ### Example
	/// ```swift
	/// Text("Orange")
	///     .foregroundStyle(AvailableColors.orange.prominentColor)
	///     .padding()
	///     .background(AvailableColors.orange.SwiftUIColor)
	/// ```
	public var prominentColor: Color {
		(self.SwiftUIColor.luminance ?? 0) < 0.5 ? .white : .black
	}
}

