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

// MARK: - ConditionalBackground
@available(iOS 13.0, macOS 10.15, visionOS 1.0, *)
public struct ConditionalBackground<Background>: ViewModifier where Background: View {
	let show: Bool
	let background: Background
	
	public func body(content: Content) -> some View {
		if show {
			content.background(background)
		} else {
			content
		}
	}
}

@available(iOS 13.0, macOS 10.15, visionOS 1.0, *)
extension View {
	public func conditionalBackground<Background>(show: Bool, @ViewBuilder background: () -> Background) -> some View where Background: View {
		modifier(ConditionalBackground(show: show, background: background()))
	}
}
