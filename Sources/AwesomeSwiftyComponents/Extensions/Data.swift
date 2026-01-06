//
//  Data.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 04.01.26.
//

import Foundation

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, visionOS 1.0, *)
extension Data: @retroactive Identifiable {
	/// <#Description#>
	public var id: Data { self }
}
