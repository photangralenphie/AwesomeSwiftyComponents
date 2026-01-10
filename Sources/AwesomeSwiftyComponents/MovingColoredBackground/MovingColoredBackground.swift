//
//  MovingColoredBackground.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 02.01.26.
//

import SwiftUI

/// An animated moving background. Specify a reusable ``MovingColoredBackgroundVm`` to create the background.
///
/// ### Example
/// ```swift
/// @State private var vm = MovingColoredBackgroundVm(initialColor: .orange)
///
/// VStack {
/// 	/* content */
/// }
/// .background { MovingColoredBackground(vm: vm) }
/// ```
/// The Background adjusts to the ColorSchema of the app:
/// Dark:
/// ![A dark moving colored background](MovingBackgroundDark)
/// Light:
/// ![A light moving colored background](MovingBackgroundLight)
@available(iOS 18.0, macOS 15.0, visionOS 2.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct MovingColoredBackground: View {
	
	let vm: MovingColoredBackgroundVm
	
	/// Creates a MovingColoredBackground
	/// - Parameter vm: The ViewModel for the background.
	public init(vm: MovingColoredBackgroundVm) {
		self.vm = vm
	}
	
	public var body: some View {
		TimelineView(.animation) { context in
			MeshGradient(
				width: 5,
				height: 5,
				points: vm.points(at: context.date),
				colors: vm.colors,
				smoothsColors: false
			)
			.ignoresSafeArea(edges: .all)
			#if os(macOS)
			.overlay(Color(.windowBackgroundColor).opacity(0.5))
			#else
			.overlay(Color(.systemBackground).opacity(0.5))
			#endif
		}
    }
}
