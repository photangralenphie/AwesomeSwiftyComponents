import SwiftUICore

extension Binding {
	public func isNotNil<T>() -> Binding<Bool> where Value == T? {
		Binding<Bool>(
			get: { self.wrappedValue != nil },
			set: { newValue in
				if !newValue { self.wrappedValue = nil }
			}
		)
	}
}
