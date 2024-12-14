//
//  LocationFooter.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 14.12.24.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ListFooter: View {
    
    let text: LocalizedStringKey
    let alignment: HorizontalAlignment
    
    public init(_ text: LocalizedStringKey, alignment: HorizontalAlignment = .center) {
        self.text = text
        self.alignment = alignment
    }
    
    public var body: some View {
        HStack {
            if alignment == .center || alignment == .trailing {
                Spacer()
            }
            Text(text)
                .foregroundStyle(Color.secondary)

            if alignment == .center {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.white.opacity(0))
        .listRowSeparator(.hidden)
        .listRowSpacing(0)
    }
}
