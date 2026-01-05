//
//  MovingColoredBackgroundView.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 02.01.26.
//

import SwiftUI

/// An animated moving background. Specify a reusable ``MovingColoredBackgroundVm`` to create the background.
@available(iOS 18.0, *)
public struct MovingColoredBackgroundView: View {
	
	let vm: MovingColoredBackgroundVm
	
	/// <#Description#>
	/// - Parameter vm: <#vm description#>
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
			#if os(iOS)
			.overlay(Color(.systemBackground).opacity(0.5))
			#else
			.overlay(Color(.windowBackgroundColor).opacity(0.5))
			#endif
		}
    }
}
