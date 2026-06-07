//
//  Character.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 07.06.26.
//

@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
extension Character {
	/// Returns `true` if the first Unicode scalar of this character has the emoji property set.
	///
	/// This does not detect full emoji sequences, only whether the first scalar is classified as an emoji by Unicode.
	/// Use in conjunction with `String.isSingleEmoji` for most cases.
	public var isEmoji: Bool {
		unicodeScalars.first?.properties.isEmoji == true
	}
}
