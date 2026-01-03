//
//  View.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 27.04.25.
//
import SwiftUI

// MARK: - TabViewSidebarBottomBar
@available(iOS 18.0, macOS 15.0, visionOS 2.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
fileprivate struct BetterTabViewSidebarBottomBar<TabViewContent:View>: ViewModifier {
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

@available(iOS 18.0, macOS 15.0, visionOS 2.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {
	public func tabViewSidebarBottomBar<TabViewContent: View>(isVisible: Bool, @ViewBuilder content: @escaping () -> TabViewContent ) -> some View {
		modifier(BetterTabViewSidebarBottomBar(isVisible: isVisible, tabViewSidebarBottomBarContent: content))
	}
}


@available(iOS 15.0, macOS 15.0, visionOS 2.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
fileprivate struct SafeAreaView<C:View>: ViewModifier {
	let edge: VerticalEdge
	let alignment: HorizontalAlignment
	let spacing: CGFloat?
	let viewContent: () -> C
	
	func body(content: Content) -> some View {
		if #available(iOS 26, *) {
			content
				.safeAreaBar(edge: edge, alignment: alignment, spacing: spacing, content: viewContent)
		} else {
			content
				.safeAreaInset(edge: edge, alignment: alignment, spacing: spacing, content: viewContent)
		}
	}
}

@available(iOS 15.0, macOS 15.0, visionOS 2.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {
	public func safeAreaView<V>(edge: VerticalEdge, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> V) -> some View where V : View {
		modifier(SafeAreaView(edge: edge, alignment: alignment, spacing: spacing, viewContent: content))
	}
}

// MARK: - ListGlassCell
@available(iOS 26, macOS 26, *)
public struct ListGlassCell<S: Shape>: ViewModifier {
	
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

@available(iOS 26, macOS 26, *)
extension View {
	public func listGlassCell(_ glass: Glass = .clear.interactive(), in shape: some Shape = DefaultGlassEffectShape()) -> some View {
		modifier(ListGlassCell(glass: glass, shape: shape))
	}
}
