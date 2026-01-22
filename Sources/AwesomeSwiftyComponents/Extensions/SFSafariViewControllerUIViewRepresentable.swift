//
//  SFSafariViewControllerUIViewRepresentable.swift
//
//  Originally by: Antoine van der Lee
//  https://www.avanderlee.com/swiftui/sfsafariviewcontroller-open-webpages-in-app/
//
//  Modified by Jonas Helmer on 28.08.24.
//

import SwiftUI

#if canImport(SafariServices)
#if canImport(UIKit)
import UIKit
import SafariServices

/// A SwiftUI wrapper for `SFSafariViewController` to present web content in-app.
///
/// Use this representable to open a URL within your app using Safari Services instead of
/// switching to the system browser. This is iOS-only and deprecated on iOS 18 in favor of WebKit.
@available(iOS 15.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(iOS, deprecated: 18.0, message: "Used WebKit instead.")
struct SFSafariViewControllerUIViewRepresentable: UIViewControllerRepresentable {

    /// Creates a representable that presents the given URL in a `SFSafariViewController`.
    /// - Parameter url: The URL to load.
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


/// Monitors the `openURL` environment variable and handles them in-app instead of via
/// the external web browser.
@available(iOS 15.0, tvOS 15.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(iOS, deprecated: 18.0, message: "Used WebKit instead.")
struct SafariViewControllerViewModifier: ViewModifier {
    /// Whether to intercept `openURL` actions and present links in-app using Safari Services.
    let useInAppBrowser: Bool
	
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
#endif
#endif

@available(iOS 15.0, tvOS 15.0, macOS 26.0, watchOS 26.0, *)
public extension View {
    /// Monitor the `openURL` environment and handle links in-app using Safari Services.
    ///
    /// When enabled, links opened via `openURL` are intercepted and presented in a sheet instead.
	///
	/// Uses an `SFSafariViewController` sheet on iOS 15-18 (Originally by: [Antoine van der Lee](https://www.avanderlee.com/swiftui/sfsafariviewcontroller-open-webpages-in-app/)
	/// Uses WebKit on iOS 26 and above.
    ///
    /// - Parameter useInAppBrowser: Pass `true` to handle links in-app, or `false` to use the system default.
    /// - Returns: A view that intercepts `openURL` and presents links in a `SFSafariViewController` on iOS 15-18 or WebKit on iOS 26 and above when enabled.
	@ViewBuilder
    func useInAppSafari(_ useInAppBrowser: Bool) -> some View {
		if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
			self.environment(\.openURL, OpenURLAction(handler: { _ in
				.systemAction(prefersInApp: useInAppBrowser)
			}))
		} else {
			#if canImport(UIKit)
			modifier(SafariViewControllerViewModifier(useInAppBrowser: useInAppBrowser))
			#endif
		}
    }
}

