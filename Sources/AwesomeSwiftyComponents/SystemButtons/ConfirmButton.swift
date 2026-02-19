//
//  ConfirmButton.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 24.01.26.
//

import SwiftUI

/// A reusable confirm button for SwiftUI that triggers a provided action.
///
/// ConfirmButton renders a platform-appropriate button to confirm something.
/// On iOS 26 and newer, it uses the system-provided
/// confirm role for buttons. On earlier OS versions, it falls back to a
/// localized "Done" label with an "xmark" system image.
///
/// You can initialize it  with a custom closure or action.
///
/// Usage with a custom action:
/// ```swift
/// var body: some View {
///     ConfirmButton { /* perform confirm */ }
/// }
/// ```
/// or:
///```swift
/// var body: some View {
///     ConfirmButton(confirm)
/// }
/// func confirm() { /* perform confirm */ }
/// ```
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct ConfirmButton: View {
	private let action: () -> Void
	
	/// Creates a ConfirmButton with a custom action.
	///
	/// - Parameter action: The closure to invoke when the button is tapped.
	public init(_ action: @escaping () -> Void) {
		self.action = action
	}
	
	public var body: some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *) {
			Button(role: .confirm, action: action)
		} else {
			Button("Done", systemImage: "checkmark", action: action)
		}
	}
}

