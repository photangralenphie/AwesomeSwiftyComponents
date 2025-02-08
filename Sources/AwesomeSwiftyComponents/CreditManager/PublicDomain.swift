//
//  MITLicence.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 15.01.25.
//

import SwiftUI

@available(iOS 14.0, *, macOS 11.0, *)
public struct PublicDomain: View {
    
    public let credit: String
    
    public var body: some View {
        List {
            Text("Public Domain")
            Text("This work by \(credit) was published into the public domain.")
        }
        .font(.footnote)
        .listStyle(.plain)
        .navigationTitle(credit)
    }
}
