//
//  String.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 05.06.26.
//

@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
extension String {
	/// Returns `true` if the string consists of exactly one character and that character is recognized as an emoji.
	///
	/// This property checks whether the string contains a single `Character` and whether that character's
	/// Unicode properties indicate it is an emoji. Complex emoji sequences (such as multi-code point family or flag emojis)
	/// that Swift treats as a single `Character` will correctly return `true`.
	///
	/// Usage Examples:
	/// ```swift
	/// "🎈".isSingleEmoji	// true
	/// "💯".isSingleEmoji	// true
	/// "A".isSingleEmoji	// false
	/// "👨‍👩‍👧‍👦".isSingleEmoji	// true
	/// ```
	public var isSingleEmoji: Bool {
		count == 1 && first?.isEmoji == true
	}
}
