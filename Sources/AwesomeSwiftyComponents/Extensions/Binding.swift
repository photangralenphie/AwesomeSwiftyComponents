import SwiftUI

extension Binding {
	/// Allows binding an arbitrary ``Swift/Optional`` value to a bool ``Swift/Binding``.
	/// - Returns: <#description#>
	@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
	public func isNotNil<T>() -> Binding<Bool> where Value == T? {
		Binding<Bool>(
			get: { self.wrappedValue != nil },
			set: { newValue in
				if !newValue { self.wrappedValue = nil }
			}
		)
	}
}
