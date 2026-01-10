//
//  Data.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 04.01.26.
//

import Foundation

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, visionOS 1.0, *)
extension Data: @retroactive Identifiable {
	/// A stable identifier for the `Data` value.
	///
	/// Conforming `Data` to `Identifiable` enables convenient use in SwiftUI lists
	/// and diffable collections without having to wrap it in another type.
	///
	/// ### Example
	/// ```swift
	/// struct HashList: View {
	///     let items: [Data]
	///     var body: some View {
	///         List(items) { data in
	///             Text(data.base64EncodedString())
	///                 .lineLimit(1)
	///         }
	///     }
	/// }
	/// ```
	public var id: Data { self }
}
