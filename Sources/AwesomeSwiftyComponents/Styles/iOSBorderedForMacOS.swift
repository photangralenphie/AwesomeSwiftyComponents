//
//  iOSBorderedForMacOS.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 23.02.25.
//

import SwiftUI

/// A Button style mimicking the bordered ButtonStyle on iOS just for macOS.
/// Applying this to a button wont change the default default ButtonStyle on iOS
@available(macOS 12.0, *)
public struct iOSBorderedForMacOS<S: Shape>: ButtonStyle {
    
    let foregroundColor: Color
    let clipShape: S
    
    public init(foregroundColor: Color = .primary, clipShape: S = Circle()) {
        self.foregroundColor = foregroundColor
        self.clipShape = clipShape
    }
	
	public func makeBody(configuration: Configuration) -> some View {
        configuration.label
        #if os(macOS)
            .foregroundStyle(foregroundColor)
            .padding(6)
            .background(
                Color.secondary
                    .overlay {
                        Color.clear.background(.regularMaterial)
                    }
                    .clipShape(Circle())
            )
        #endif
    }
}
