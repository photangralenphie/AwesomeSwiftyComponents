//
//  MovingColoredBackgroundView.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 02.01.26.
//

import SwiftUI

@available(iOS 18.0, *)
public struct MovingColoredBackgroundView: View {
	
	public let vm: MovingColoredBackgroundVm
	
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
