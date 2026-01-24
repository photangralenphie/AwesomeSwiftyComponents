//
//  DestructiveButton.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 24.01.26.
//

import SwiftUI

/// A reusable destructive button for SwiftUI that triggers a provided action.
///
/// DestructiveButton renders a platform-appropriate button to delete something.
/// On iOS 26 and newer, it uses the system-provided
/// destructive  role for buttons. On earlier OS versions, it falls back to a
/// localized "Delete" label with an "trash" system image.
///
/// You can initialize it  with a custom closure or action.
///
/// Usage with a custom action:
/// ```swift
/// var body: some View {
///     DestructiveButton { /* perform delete */ }
/// }
/// ```
/// or:
///```swift
/// var body: some View {
///     DestructiveButton(delete)
/// }
/// func delete() { /* perform delete */ }
/// ```
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct DestructiveButton: View {
	private let action: () -> Void
	
	/// Creates a DestructiveButton with a custom action.
	///
	/// - Parameter action: The closure to invoke when the button is tapped.
	public init(_ action: @escaping () -> Void) {
		self.action = action
	}
	
	public var body: some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
			Button(role: .destructive, action: action)
		} else if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *){
			Button("Delete", systemImage: "trash", role: .destructive, action: action)
		} else {
			Button("Delete", systemImage: "trash", action: action)
		}
	}
}
