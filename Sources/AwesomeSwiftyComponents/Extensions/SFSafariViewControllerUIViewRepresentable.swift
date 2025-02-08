//
//  SFSafariViewControllerUIViewRepresentable.swift
//
//  Originally by: Antoine van der Lee
//  https://www.avanderlee.com/swiftui/sfsafariviewcontroller-open-webpages-in-app/
//
//  Modified by Jonas Helmer on 28.08.24.
//


import SwiftUI
#if !os(macOS)
import UIKit
import SafariServices

@available(iOS 13.0, *)
public struct SFSafariViewControllerUIViewRepresentable: UIViewControllerRepresentable {

    let url: URL
    
    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewControllerUIViewRepresentable>) {
        // No need to do anything here
    }
}
#endif


/// Monitors the `openURL` environment variable and handles them in-app instead of via
/// the external web browser.
@available(iOS 15.0, *)
@available(macOS 10.15, *)
private struct SafariViewControllerViewModifier: ViewModifier {
    public let useInAppBrowser: Bool
    @State private var urlToOpen: URL?

    func body(content: Content) -> some View {
        content
		#if !os(macOS)
            .environment(\EnvironmentValues.openURL, OpenURLAction { url in
                if (!useInAppBrowser) {
                    return .systemAction
                }

                /// Catch any URLs that are about to be opened in an external browser.
                /// Instead, handle them here and store the URL to reopen in our sheet.
                urlToOpen = url
                return .handled
            })
            .sheet(isPresented: Binding(
                get: { urlToOpen != nil },
                set: { if !$0 { urlToOpen = nil } }
            )) {
                if let urlToOpen = urlToOpen {
                    SFSafariViewControllerUIViewRepresentable(url: urlToOpen)
                }
            }
		#endif
    }
}

@available(iOS 15.0, *)
@available(macOS 10.15, *)
public extension View {
    /// Monitor the `openURL` environment variable and handle them in-app instead of viathe external web browser.
    /// Does nothing on macOS
	///
    /// Uses the `SafariViewWrapper` which will present the URL in a `SFSafariViewController`.
    /// Originally by: [Antoine van der Lee](https://www.avanderlee.com/swiftui/sfsafariviewcontroller-open-webpages-in-app/)

    func useInAppSafari(_ useInAppBrowser: Bool) -> some View {
        modifier(SafariViewControllerViewModifier(useInAppBrowser: useInAppBrowser))
    }
}
