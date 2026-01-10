//
//  View.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 27.04.25.
//

import SwiftUI

// MARK: - BetterTabViewSidebarBottomBar

/// Conditionally applies a sidebar bottom bar to a `TabView`.
///
/// This modifier is useful when a sidebar-style bottom bar should only be shown
/// in specific UI states (for example, depending on selection or window size).
///
/// The modifier is a no-op when `isVisible` is `false`.
@available(iOS 18.0, macOS 15.0, visionOS 2.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct BetterTabViewSidebarBottomBar<TabViewContent: View>: ViewModifier {

	/// Controls whether the sidebar bottom bar is applied.
	let isVisible: Bool

	/// The content shown in the sidebar bottom bar.
	let tabViewSidebarBottomBarContent: () -> TabViewContent

	func body(content: Content) -> some View {
		if isVisible {
			content.tabViewSidebarBottomBar(content: tabViewSidebarBottomBarContent)
		} else {
			content
		}
	}
}

// MARK: - SafeAreaView

/// A compatibility wrapper for adding content to the safe area.
///
/// Uses `.safeAreaBar` on newer OS versions and automatically falls back to
/// `.safeAreaInset` on earlier systems.
///
/// This allows a single API surface while adopting newer layout behavior
/// when available.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@available(visionOS, unavailable)
struct SafeAreaView<C: View>: ViewModifier {

	/// The vertical edge where the content is inserted.
	let edge: VerticalEdge

	/// Horizontal alignment of the inserted content.
	let alignment: HorizontalAlignment

	/// Optional spacing between the safe area and the inserted content.
	let spacing: CGFloat?

	/// The view displayed inside the safe area.
	let viewContent: () -> C

	func body(content: Content) -> some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
			content.safeAreaBar(
				edge: edge,
				alignment: alignment,
				spacing: spacing,
				content: viewContent
			)
		} else {
			content.safeAreaInset(
				edge: edge,
				alignment: alignment,
				spacing: spacing,
				content: viewContent
			)
		}
	}
}

// MARK: - ListGlassCell

/// Applies a glass background to list or form rows.
///
/// This modifier clears the default row background and replaces it with
/// a glass effect clipped to a custom shape.
@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
@available(visionOS, unavailable)
struct ListGlassCell<S: Shape>: ViewModifier {

	/// The glass style applied to the row.
	let glass: Glass

	/// The shape used to clip the glass effect.
	let shape: S

	public func body(content: Content) -> some View {
		content
			.listRowBackground(
				Color.clear
					.glassEffect(glass, in: shape)
			)
	}
}

// MARK: - View Extensions

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
extension View {

	/// Conditionally adds a sidebar bottom bar to a `TabView`.
	///
	/// Use this modifier to dynamically show or hide sidebar bottom bar content
	/// without restructuring the view hierarchy.
	///
	/// - Parameters:
	///   - isVisible: A Boolean value that determines whether the bottom bar is shown.
	///   - content: The view displayed inside the sidebar bottom bar.
	///
	/// ### Example
	/// ```swift
	/// TabView {
	///     ContentView()
	/// }
	/// .tabViewSidebarBottomBar(isVisible: selection != nil) {
	///     SidebarControls()
	/// }
	/// ```
	@available(iOS 18.0, macOS 15.0, visionOS 2.0, *)
	@available(tvOS, unavailable)
	@available(watchOS, unavailable)
	public func tabViewSidebarBottomBar<TabViewContent: View>(
		isVisible: Bool,
		@ViewBuilder content: @escaping () -> TabViewContent
	) -> some View {
		modifier(
			BetterTabViewSidebarBottomBar(
				isVisible: isVisible,
				tabViewSidebarBottomBarContent: content
			)
		)
	}

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
	@available(iOS 15.0, macOS 15.0, visionOS 2.0, *)
	@available(tvOS, unavailable)
	@available(watchOS, unavailable)
	@available(visionOS, unavailable)
	public func safeAreaView<V: View>(
		edge: VerticalEdge,
		alignment: HorizontalAlignment = .center,
		spacing: CGFloat? = nil,
		@ViewBuilder content: @escaping () -> V
	) -> some View {
		modifier(
			SafeAreaView(
				edge: edge,
				alignment: alignment,
				spacing: spacing,
				viewContent: content
			)
		)
	}

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
		modifier(ListGlassCell(glass: glass, shape: shape))
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

