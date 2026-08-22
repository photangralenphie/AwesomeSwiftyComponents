//
//  ShakeDetector.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 01.08.26.
//


import SwiftUI

struct ShakeDetector: UIViewControllerRepresentable {
    let onShake: () -> Void

    func makeUIViewController(context: Context) -> Controller {
        Controller(onShake: onShake)
    }

    func updateUIViewController(
        _ controller: Controller,
        context: Context
    ) {
        controller.onShake = onShake
    }

    final class Controller: UIViewController {
        var onShake: () -> Void

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