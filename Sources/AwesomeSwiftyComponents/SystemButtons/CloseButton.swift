//
//  CloseButton.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 23.01.26.
//

import SwiftUI

/// A reusable close button for SwiftUI that triggers a provided action.
///
/// CloseButton renders a platform-appropriate button to dismiss or close the
/// current presentation. On iOS 26 and newer, it uses the system-provided
/// close role for buttons. On earlier OS versions, it falls back to a
/// localized "Close" label with an "xmark" system image.
///
/// You can initialize it with either a `DismissAction` from the environment
/// or with a custom closure.
///
/// Usage with DismissAction:
/// ```swift
/// @Environment(\.dismiss) private var dismiss
///
/// var body: some View {
///     CloseButton(dismiss)
/// }
/// ```
///
/// Usage with a custom action:
/// ```swift
/// var body: some View {
///     CloseButton { /* perform close */ }
/// }
/// ```
/// or:
///```swift
/// var body: some View {
///     CloseButton(close)
/// }
/// func close() { /* perform close */ }
/// ```
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct CloseButton: View {
	private let action: () -> Void
	
	/// Creates a CloseButton that dismisses the current presentation.
	///
	/// - Parameter dismiss: The environment dismiss action to call when tapped.
	@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
	public init(_ dismiss: DismissAction) {
		self.action = dismiss.callAsFunction
	}
	
	/// Creates a CloseButton with a custom action.
	///
	/// - Parameter action: The closure to invoke when the button is tapped.
	public init(_ action: @escaping () -> Void) {
		self.action = action
	}
	
    public var body: some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *) {
			Button(role: .close, action: action)
		} else {
			Button("Close", systemImage: "xmark", action: action)
		}
    }
}

