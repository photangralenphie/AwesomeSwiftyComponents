//
//  LocationFooter.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 14.12.24.
//

import SwiftUI

/// A footer for a list. Ideal to display the number of items in the lit.
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
public struct ListFooter: View {
    
    private let text: LocalizedStringKey
    private let alignment: HorizontalAlignment
	
	/// Creates a list footer
	/// - Parameters:
	///   - text: The text to display in the label
	///   - alignment: The alignment of the footer text (default: .center).
	public init(_ text: LocalizedStringKey, alignment: HorizontalAlignment = .center) {
        self.text = text
        self.alignment = alignment
    }
    
    public var body: some View {
		Section {
			HStack() {
				if alignment == .center || alignment == .trailing {
					Spacer()
				}

				Text(text)
					.foregroundStyle(Color.secondary)

				if alignment == .center || alignment == .leading {
					Spacer()
				}
			}
			.frame(maxWidth: .infinity)
			.listRowBackground(Color.white.opacity(0))
			#if !os(tvOS) && !os(watchOS)
			.listRowSeparator(.hidden)
			#endif
		}
    }
}
