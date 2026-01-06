//
//  SwiftUIView.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 06.01.26.
//

import SwiftUI

/// Creates a tinted emoji in the set `SwiftUI/Color/accentColor`.
/// Works best with emojis with one or few colors.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct TintedEmoji: View {
	
	private let emoji: String
	
	/// Creates a tinted emoji in the set `SwiftUI/Color/accentColor`.
	/// Works best with emojis with one or few colors.
	/// - Parameter emoji: The emoji to use,
	public init(_ emoji: String) {
		self.emoji = emoji
	}
	
    public var body: some View {
		Text(emoji)
			.opacity(0)
			.overlay{
				Color.accentColor
					.mask(Text(emoji))
			}
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public extension Label where Title == Text, Icon == TintedEmoji {
	/// Creates a `SwiftUI/Label` from a title and an emoji
	/// - Parameters:
	///   - title: The title of the label.
	///   - emoji: The emoji of the label used as icon.
	init(_ title: LocalizedStringKey, emoji: String) {
		self.init {
			Text(title)
		} icon: {
			TintedEmoji(emoji)
		}
	}
}
