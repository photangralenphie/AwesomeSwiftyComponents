//
//  Glass.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 21.01.26.
//

import Foundation
import SwiftUI

@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
@available(visionOS, unavailable)
extension Glass {
	/// A `Glass` style that mimics the glass style of the build in Tabbar
	/// - Parameter colorSchema: The `ColorSchema` read from the environments
	public static func bar(for colorSchema: ColorScheme) -> Glass {
		if colorSchema == .dark {
			return .clear.tint(.black.opacity(0.3))
		} else {
			return .clear.tint(.white.opacity(0.35))
		}
	}
}
