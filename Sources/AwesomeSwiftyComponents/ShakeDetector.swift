//
//  ShakeDetector.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 01.08.26.
//

import SwiftUI
#if canImport(UIKit)
import UIKit

/// A UIKit bridge that forwards device shake gestures to SwiftUI.
///
/// `ShakeDetector` installs a view controller in a SwiftUI view hierarchy. The
/// controller becomes the first responder when it appears and invokes
/// ``onShake`` after receiving a shake motion event.
///
/// Use the `onShake(perform:)` view modifier instead of adding this
/// representable directly to a view hierarchy.
@available(iOS 13.0, tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
struct ShakeDetector: UIViewControllerRepresentable {
	/// The action to perform when the device detects a shake gesture.
	let onShake: () -> Void

	/// Creates the view controller that listens for device motion events.
	func makeUIViewController(context: Context) -> Controller {
		Controller(onShake: onShake)
	}

	/// Updates the controller with the latest shake action from SwiftUI.
	func updateUIViewController(
		_ controller: Controller,
		context: Context
	) {
		controller.onShake = onShake
	}

	/// A view controller that becomes the first responder and handles shake events.
	final class Controller: UIViewController {
		/// The action to perform when the controller receives a shake event.
		var onShake: () -> Void

		/// Creates a controller with an action to perform for shake events.
		///
		/// - Parameter onShake: The action to perform when the device is shaken.
		init(onShake: @escaping () -> Void) {
			self.onShake = onShake
			super.init(nibName: nil, bundle: nil)
		}

		@available(*, unavailable)
		required init?(coder: NSCoder) {
			fatalError()
		}

		override var canBecomeFirstResponder: Bool {
			true
		}

		override func viewDidAppear(_ animated: Bool) {
			super.viewDidAppear(animated)
			becomeFirstResponder()
		}

		override func motionEnded(
			_ motion: UIEvent.EventSubtype,
			with event: UIEvent?
		) {
			guard motion == .motionShake else { return }
			onShake()
		}
	}
}

#endif
