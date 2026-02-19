//
//  View.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 27.04.25.
//

import SwiftUI


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
extension View {

	/// Inserts a view into the safe area with automatic OS version handling.
	///
	/// This modifier adopts `.safeAreaBar` on newer systems and falls back to
	/// `.safeAreaInset` when necessary.
	///
	/// - Parameters:
	///   - edge: The vertical edge where the content is inserted.
	///   - alignment: Horizontal alignment of the inserted view.
	///   - spacing: Optional spacing between the content and the safe area.
	///   - content: The view to place inside the safe area.
	///
	/// ### Example
	/// ```swift
	/// Color.blue
	///     .safeAreaView(edge: .bottom) {
	///         PlayerControls()
	///     }
	/// ```
	@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
	@ViewBuilder
	public func safeAreaView<V: View>(
		edge: VerticalEdge,
		alignment: HorizontalAlignment = .center,
		spacing: CGFloat? = nil,
		@ViewBuilder content: @escaping () -> V
	) -> some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *) {
			self.safeAreaBar(
				edge: edge,
				alignment: alignment,
				spacing: spacing,
				content: content
			)
		} else {
			self.safeAreaInset(
				edge: edge,
				alignment: alignment,
				spacing: spacing,
				content: content
			)
		}
	}

	// MARK: - Liquid Glass -
	
	/// Applies a glass effect to list or form cells.
	///
	/// The default configuration uses an interactive clear glass effect
	/// and a platform-appropriate default shape.
	///
	/// - Parameters:
	///   - glass: The glass style to apply.
	///   - shape: The shape used to clip the glass effect.
	///
	/// ### Example
	/// ```swift
	/// List {
	///     Text("Settings")
	///         .listGlassCell()
	/// }
	/// ```
	@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
	@available(visionOS, unavailable)
	public func listGlassCell(
		_ glass: Glass = .clear.interactive(),
		in shape: some Shape = DefaultGlassEffectShape()
	) -> some View {
		self.listRowBackground(Color.clear.glassEffect(glass, in: shape))
	}

	/// Applies a bordered button style on earlier OS versions
	/// and automatically switches to glass on newer systems.
	///
	/// This helps maintain visual consistency while adopting modern
	/// button styles when available.
	@available(iOS 15.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
	@available(visionOS, unavailable)
	@ViewBuilder
	public func glassOrBorderedButtonStyle() -> some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
			self.buttonStyle(.glass)
		} else {
			self.buttonStyle(.bordered)
		}
	}

	/// Applies a prominent bordered button style on earlier OS versions
	/// and switches to a prominent glass style on newer systems.
	@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
	@available(visionOS, unavailable)
	@ViewBuilder
	public func glassOrBorderedProminentButtonStyle() -> some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
			self.buttonStyle(.glassProminent)
		} else {
			self.buttonStyle(.borderedProminent)
		}
	}
}
