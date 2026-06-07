import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
extension Binding {
	/// Produces a Boolean binding that reflects whether this optional binding has a value.
	///
	/// The returned binding reads as `true` when `wrappedValue` is non-`nil`, and `false` otherwise.
	/// Setting the returned binding to `false` clears the original binding by assigning `nil`.
	/// Setting it to `true` has no effect on the underlying value.
	///
	/// - Returns: A `Binding<Bool>` that is `true` when the optional contains a value and `false` when it is `nil`.
	public func isNotNil<T>() -> Binding<Bool> where Value == T? {
		Binding<Bool>(
			get: { self.wrappedValue != nil },
			set: { newValue in
				if !newValue { self.wrappedValue = nil }
			}
		)
	}
}

extension Binding<Bool> {
	/// Returns a binding that represents the logical negation of this Boolean binding.
	///
	/// The returned binding reads as the logical NOT of this binding's value. Setting the returned binding
	/// updates the original binding with the negated value of the assignment.
	///
	/// - Returns: A `Binding<Bool>` that reflects the logical negation of this binding.
	public func negate() -> Binding<Bool> {
		Binding {
			!self.wrappedValue
		} set: { newValue in
			self.wrappedValue = !newValue
		}
	}
}
