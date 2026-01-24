//
//  CancelButton.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 24.01.26.
//

import SwiftUI

/// A reusable cancel button for SwiftUI that triggers a provided action.
///
/// CancelButton renders a platform-appropriate button to cancel something.
/// On iOS 26 and newer, it uses the system-provided
/// cancel role for buttons. On earlier OS versions, it falls back to a
/// localized "Cancel" label with an "xmark" system image.
///
/// You can initialize it  with a custom closure or action.
///
/// Usage with a custom action:
/// ```swift
/// var body: some View {
///     ConfirmButton { /* perform cancel */ }
/// }
/// ```
/// or:
///```swift
/// var body: some View {
///     ConfirmButton(close)
/// }
///  func cancel() { /* perform cancel */ }
/// ```
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct CancelButton: View {
	private let action: () -> Void
	
	/// Creates a CancelButton with a custom action.
	///
	/// - Parameter action: The closure to invoke when the button is tapped.
	public init(_ action: @escaping () -> Void) {
		self.action = action
	}
	
	public var body: some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
			Button(role: .cancel, action: action)
		} else if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *){
			Button("Cancel", systemImage: "xmark", role: .cancel, action: action)
		} else {
			Button("Cancel", systemImage: "xmark", action: action)
		}
	}
}
