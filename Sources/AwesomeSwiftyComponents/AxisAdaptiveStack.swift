//
//  AxisAdaptiveStack.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 28.01.26.
//

import SwiftUI

/// A stack that adapts its axis based on the current horizontal size class.
///
/// - In compact environments (like iPhone portrait), the stack renders its content in a `VStack`.
/// - In regular environments (like iPad or iPhone landscape on larger devices), the stack renders its content in an `HStack`.
///
/// This is useful when you want a single layout that automatically switches between vertical and horizontal arrangements depending on the device or window size, while still letting you customize alignment and spacing for each orientation.
///
/// Example
/// ```swift
/// AxisAdaptiveStack(
///     verticalAlignment: .leading,        // Alignment used when stacked vertically (VStack)
///     verticalSpacing: 8,                 // Spacing used when stacked vertically (VStack)
///     horizontalAlignment: .center,       // Alignment used when stacked horizontally (HStack)
///     horizontalSpacing: 16               // Spacing used when stacked horizontally (HStack)
/// ) {
///     Text("Title").font(.headline)
///     Text("Subtitle").foregroundStyle(.secondary)
///     Button("Action") { /* ... */ }
/// }
/// ```
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct AxisAdaptiveStack<Content>: View where Content: View {
	
	private let content: Content
	private let verticalAlignment: HorizontalAlignment
	private let verticalSpacing: CGFloat?
	private let horizontalAlignment: VerticalAlignment?
	private let horizontalSpacing: CGFloat?
	
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	/// Creates an axis-adaptive stack.
	///
	/// - Parameters:
	///   - verticalAlignment: The horizontal alignment used when the stack renders as a `VStack`.  Defaults to `.center`.
	///   - verticalSpacing: The spacing between elements when the stack renders as a `VStack`. Defaults to `nil` to use the system default spacing.
	///   - horizontalAlignment: The vertical alignment used when the stack renders as an `HStack`. Defaults to `.center`.
	///   - horizontalSpacing: The spacing between elements when the stack renders as an `HStack`. Defaults to `nil` to use the system default spacing.
	///   - content: A view builder that produces the arranged content.
	public init(verticalAlignment: HorizontalAlignment = .center, verticalSpacing: CGFloat? = nil, horizontalAlignment: VerticalAlignment = .center, horizontalSpacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
		self.content = content()
		self.verticalAlignment = verticalAlignment
		self.verticalSpacing = verticalSpacing
		self.horizontalAlignment = horizontalAlignment
		self.horizontalSpacing = horizontalSpacing
	}
	
	/// Creates an axis-adaptive stack.
	///
	/// - Parameters:
	///   - verticalAlignment: The horizontal alignment used when the stack renders as a `VStack`.  Defaults to `.center`.
	///   - horizontalAlignment: The vertical alignment used when the stack renders as an `HStack`. Defaults to `.center`.
	///   - spacing: The spacing between elements  Defaults to `nil` to use the system default spacing.
	///   - content: A view builder that produces the arranged content.
	public init(verticalAlignment: HorizontalAlignment = .center, horizontalAlignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
		self.content = content()
		self.verticalAlignment = verticalAlignment
		self.verticalSpacing = spacing
		self.horizontalAlignment = horizontalAlignment
		self.horizontalSpacing = spacing
	}
		
    public var body: some View {
        if horizontalSizeClass == .compact {
			VStack(alignment: verticalAlignment, spacing: verticalSpacing) {
				content
			}
		} else {
			HStack(alignment: horizontalAlignment ?? .center, spacing: horizontalSpacing) {
				content
			}
		}
    }
}

