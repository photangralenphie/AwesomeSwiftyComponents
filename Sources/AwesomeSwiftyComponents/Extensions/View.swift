//
//  View.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 27.04.25.
//
import SwiftUI

@available(iOS 18.0, macOS 15.0, visionOS 2.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct BetterTabViewSidebarBottomBar<TabViewContent:View>: ViewModifier {
	let isVisible: Bool
	let tabViewSidebarBottomBarContent: () -> TabViewContent
	
	func body(content: Content) -> some View {
		if(isVisible) {
			content.tabViewSidebarBottomBar(content: tabViewSidebarBottomBarContent)
		} else {
			content
		}
	}
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@available(visionOS, unavailable)
struct SafeAreaView<C:View>: ViewModifier {
	let edge: VerticalEdge
	let alignment: HorizontalAlignment
	let spacing: CGFloat?
	let viewContent: () -> C
	
	func body(content: Content) -> some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
			content
				.safeAreaBar(edge: edge, alignment: alignment, spacing: spacing, content: viewContent)
		} else {
			content
				.safeAreaInset(edge: edge, alignment: alignment, spacing: spacing, content: viewContent)
		}
	}
}

@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
@available(visionOS, unavailable)
struct ListGlassCell<S: Shape>: ViewModifier {
	
	let glass: Glass
	let shape: S
	
	public func body(content: Content) -> some View {
		content
			.listRowBackground(
				Color.clear
					.glassEffect(.clear.interactive(), in: shape)
			)
	}
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
extension View {
	/// <#Description#>
	/// - Parameters:
	///   - isVisible: <#isVisible description#>
	///   - content: <#content description#>
	@available(iOS 18.0, macOS 15.0, visionOS 2.0, *)
	@available(tvOS, unavailable)
	@available(watchOS, unavailable)
	public func tabViewSidebarBottomBar<TabViewContent: View>(isVisible: Bool, @ViewBuilder content: @escaping () -> TabViewContent ) -> some View {
		modifier(BetterTabViewSidebarBottomBar(isVisible: isVisible, tabViewSidebarBottomBarContent: content))
	}
	
	/// <#Description#>
	/// - Parameters:
	///   - edge: <#edge description#>
	///   - alignment: <#alignment description#>
	///   - spacing: <#spacing description#>
	///   - content: <#content description#>
	@available(iOS 15.0, macOS 15.0, visionOS 2.0, *)
	@available(tvOS, unavailable)
	@available(watchOS, unavailable)
	@available(visionOS, unavailable)
	public func safeAreaView<V>(edge: VerticalEdge, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> V) -> some View where V : View {
		modifier(SafeAreaView(edge: edge, alignment: alignment, spacing: spacing, viewContent: content))
	}
	
	/// Turns cells of Lists and Forms into glass.
	/// - Parameters:
	///   - glass: The glass to use (default: .clear.interactive())
	///   - shape: The shape of the cell (default: DefaultGlassEffectShape())
	@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *)
	@available(visionOS, unavailable)
	public func listGlassCell(_ glass: Glass = .clear.interactive(), in shape: some Shape = DefaultGlassEffectShape()) -> some View {
		modifier(ListGlassCell(glass: glass, shape: shape))
	}
	
	/// Applies the .bordered on iOS 18 and earlier or the .glass on iOS 26 and later
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

	/// Applies the .borderedProminent on iOS 18 and earlier or the .glassProminent on iOS 26 and later
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
