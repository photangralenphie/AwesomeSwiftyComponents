//
//  BSD2-Clause.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 11.01.26.
//

import SwiftUI
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
struct BSD2_Clause: View {
	
	let name: String
	let year: String
	let copyrightHolder: String
	
    var body: some View {
		List {
			Section {
				Text("The 2-Clause BSD License")
				Text("Copyright \(year) \(copyrightHolder)")
				Text("Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:")
				Text("1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.")
				Text("2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.")
				Text("THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.")
			}
		}
		.font(.footnote)
		.listStyle(.plain)
		.navigationTitle(name)
    }
}
