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
/// Use the init without the color, so the icon adapts the current `Color.accentColor`.
/// Or specify a custom `Color`.
///
/// ### Examples
/// ```swift
/// Form {
/// 	HStack {
///			TintedEmoji("🔝")
///			TintedEmoji("💯", color: .green)
///			TintedEmoji("🎈", color: .cyan)
///			TintedEmoji("💕", color: .orange)
///			TintedEmoji("❌", color: .yellow)
///			TintedEmoji("🩸", color: .purple)
///		}
/// }
/// ```
///
/// ![Tinted Emojis in a cell of a Form](TintedEmojis)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct TintedEmoji: View {
	
	private let emoji: Text
	private let color: Color
	private let tinted: Bool
	
	/// Creates a tinted emoji.
	/// Works best with emojis with one or few colors.
	/// - Parameter emoji: The emoji to use,
	/// - Parameter color: The color to use (default: Color.accentColor).
	public init(_ emoji: Character, color: Color = .accentColor) {
		self.emoji = Text(String(emoji))
		self.color = color
		self.tinted = true
	}
	
	internal init (_ emoji: Character, color: Color, tinted: Bool) {
		self.emoji = Text(String(emoji))
		self.color = color
		self.tinted = tinted
	}
	
    public var body: some View {
		if tinted {
			emoji
				.opacity(0)
				.overlay {
					color.mask(emoji)
				}
		} else {
			emoji
		}
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
@MainActor
public extension Label where Title == Text, Icon == TintedEmoji {
	/// Creates a ``SwiftUI/Label`` from a title and an emoji
	///
	/// - Parameters:
	///   - title: The title of the label.
	///   - emoji: The emoji of the label used as icon.
	///   - tinted: Whether the emoji should have a tint or not (default: true).
	/// 
	/// ### Example
	/// ```swift
	/// Form {
	///		Label("Label 1 with tinted emoji", emoji: "🔝")
	///		Label("Label 2 with tinted emoji", emoji: "💯")
	///		Label("Label 3 with emoji", emoji: "🎈", tinted: false)
	///		Label("Label 4 with emoji", emoji: "🤘", tinted: false)
	///	}
	/// ```
	///
	/// ![The Added Label with a text an a emoji](LabelWithEmoji)
	init(_ title: LocalizedStringKey, emoji: Character, tinted: Bool = true) {
		self.init {
			Text(title)
		} icon: {
			TintedEmoji(emoji, color: .accentColor, tinted: tinted)
		}
	}
	
	/// Creates a ``SwiftUI/Label`` from a title and an emoji
	///
	/// - Parameters:
	///   - title: The title of the label.
	///   - emoji: The emoji of the label used as icon.
	///   - tinted: Whether the emoji should have a tint or not (default: true).
	///
	/// ### Example
	/// ```swift
	/// Form {
	///		Label("Label 1 with tinted emoji", emoji: "🔝")
	///		Label("Label 2 with tinted emoji", emoji: "💯")
	///		Label("Label 3 with emoji", emoji: "🎈", tinted: false)
	///		Label("Label 4 with emoji", emoji: "🤘", tinted: false)
	///	}
	/// ```
	///
	/// ![The Added Label with a text an a emoji](LabelWithEmoji)
	init(_ title: String, emoji: Character, tinted: Bool = true) {
		self.init {
			Text(title)
		} icon: {
			TintedEmoji(emoji, color: .accentColor, tinted: tinted)
		}
	}
}

