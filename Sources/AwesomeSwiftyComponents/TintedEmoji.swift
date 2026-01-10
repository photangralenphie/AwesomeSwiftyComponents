//
//  SwiftUIView.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 06.01.26.
//

import SwiftUI

/// Creates a tinted emoji.
/// Works best with emojis with one or few colors.
///
/// Example:
/// ```swift
/// TintedEmoji("🔥", color: .red)
/// ```
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct TintedEmoji: View {
	
	private let emoji: Text
	private let color: Color
	
	/// Creates a tinted emoji.
	/// Works best with emojis with one or few colors.
	/// - Parameter emoji: The emoji to use,
	/// - Parameter color: The color to use (default: Color.accentColor).
	public init(_ emoji: Character, color: Color = .accentColor) {
		self.emoji = Text(String(emoji))
		self.color = color
	}
	
    public var body: some View {
		emoji
			.opacity(0)
			.overlay {
				color.mask(emoji)
			}
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public extension Label where Title == Text, Icon == TintedEmoji {
	/// Creates a ``SwiftUI/Label`` from a title and an emoji
	/// - Parameters:
	///   - title: The title of the label.
	///   - emoji: The emoji of the label used as icon.
	///
	/// Example:
	/// ```swift
	/// Label("Fire", emoji: "🔥")
	/// ```
	init(_ title: LocalizedStringKey, emoji: Character) {
		self.init { Text(title) } icon: { TintedEmoji(emoji) }
	}
}

