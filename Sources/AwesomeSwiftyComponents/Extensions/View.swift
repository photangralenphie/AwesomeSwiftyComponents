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
		self.modifier(BetterTabViewSidebarBottomBar(isVisible: isVisible, tabViewSidebarBottomBarContent: content))
	}
}
