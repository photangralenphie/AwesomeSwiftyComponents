//
//  LocationFooter.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 14.12.24.
//

import SwiftUI

/// A flexible footer view for a `List` or `Form`, ideal for displaying summary information like the number of items.
///
/// ### Example
/// ```swift
/// List {
///     Label("Label 1 with tinted emoji", emoji: "🔝")
///     Label("Label 2 with tinted emoji", emoji: "💯")
///     Label("Label 3 with emoji", emoji: "🎈", tinted: false)
///     Label("Label 4 with emoji", emoji: "🤘", tinted: false)
///     // Centered by default
///     ListFooter("4 Elements in List")
///     // Explicitly aligned
///     ListFooter(alignment: .leading) { Text("Custom aligned footer") }
/// }
/// ```
/// ![Adding a footer to a List or Form](ListFooter)
///
/// - Note: The footer can be customized with any `View` via the view builder initializer, or as simple text using the convenience initializer.
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
public struct ListFooter<Content>: View where Content : View {
    
    private let content: Content
    private let alignment: HorizontalAlignment
	
    /// Creates a centered list footer with custom content.
    /// - Parameter content: The view to display as the footer.
	public init(@ViewBuilder _ content: () -> Content) {
		self.alignment = HorizontalAlignment.center
		self.content = content()
	}
	
    /// Creates a list footer with custom alignment and content.
    /// - Parameters:
    ///   - alignment: The horizontal alignment of the footer content.
    ///   - content: The view to display as the footer.
	public init(alignment: HorizontalAlignment, @ViewBuilder _ content: () -> Content) {
		self.alignment = alignment
		self.content = content()
	}
    
    public var body: some View {
		Section {
			HStack {
				if alignment == .center || alignment == .trailing {
					Spacer()
				}

				content

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

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
extension ListFooter where Content == Text {
    /// Creates a list footer
    /// - Parameters:
    ///   - text: The text to display in the label
    ///   - alignment: The alignment of the footer text (default: .center).
    public init(_ text: LocalizedStringKey, alignment: HorizontalAlignment = .center) {
        self.init(alignment: alignment) {
            Text(text)
				.foregroundStyle(Color.secondary)
        }
    }
}
