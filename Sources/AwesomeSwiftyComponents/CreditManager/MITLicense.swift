//
//  MITLicence.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 15.01.25.
//

import SwiftUI

@available(iOS 14.0, *)
public struct MITLicense: View {
    
    private let name: String
    private let year: String
    private let author: String
    
    public init(name: String, year: String, author: String) {
        self.name = name
        self.year = year
        self.author = author
    }
    
    public var body: some View {
        List {
            Section {
                Text("MIT License")
                Text("Copyright (c) \(year) \(author)")
                Text("Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the right to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:")
                Text("The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.")
                Text("THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.")
            }
        }
        .font(.footnote)
        .listStyle(.plain)
        .navigationTitle(name)
    }
}
