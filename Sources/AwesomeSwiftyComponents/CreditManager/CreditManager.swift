#if !os(macOS)

import SwiftUI

@available(iOS 18.0, *)
public struct CreditManager<Content: View>: View {
    @ViewBuilder public var content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
        
    public var body: some View {
        NavigationStack {
            Form {
                ForEach(sections: content) { section in
                    Section(header: section.header) {
                        section.content
                    }
                }
            }
            .navigationTitle("Credits")
        }
    }
}

@available(iOS 18.0, *)
public struct LinkedCreditManager<Content: View>: View {
    @ViewBuilder public var content: Content
    let text: LocalizedStringKey
    let systemImage: String
    
    public init(text: LocalizedStringKey = "Credits", systemImage: String = "text.document.fill", @ViewBuilder content: () -> Content) {
        self.content = content()
        self.text = text
        self.systemImage = systemImage
    }
    
    public var body: some View {
        NavigationLink {
            CreditManager {
                content
            }
        } label: {
            Label(text, systemImage: systemImage)
        }
    }
}

public enum Licence {
    case mit(name: String, author: String, year: String)
    case apache(name: String, author: String, year: String)
    case CC0(credit: String)
    case CC_BY_SA_2_0(credit: String)
    case CC_BY_SA_3_0(credit: String)
    case CC_BY_SA_4_0(credit: String)
    case CC_BY_2_0(credit: String)
    case CC_BY_2_5(credit: String)
    case CC_BY_3_0(credit: String)
    case publicDomain(credit: String)
    
    public var description: String {
        switch self {
        case .mit(let name, let author, let year):
            return "MIT Licence"
        case .apache(let name, let author, let year):
            return "Apache License V2.0"
        case .CC0(let credit):
            return "CC0"
        case .CC_BY_SA_2_0(let credit):
            return "CC BY SA 2.0"
        case .CC_BY_SA_3_0(let credit):
            return "CC BY SA 3.0"
        case .CC_BY_SA_4_0(let credit):
            return "CC BY SA 4.0"
        case .CC_BY_2_0(let credit):
            return "CC BY 2.0"
        case .CC_BY_2_5(let credit):
            return "CC BY 2.5"
        case .CC_BY_3_0(let credit):
            return "CC BY 3.0"
        case .publicDomain(let credit):
            return "Public Domain"
        }
    }
}

@available(iOS 14.0, *)
public struct LicenceView: View {
    
    private let licence: Licence
    private let label: String
    
    public init(licence: Licence) {
        self.licence = licence
        
        switch licence {
        case .mit(let name, author: _, year: _):
            self.label = name
        case .apache(let name, author: _, year: _):
            self.label = name
        case .CC0(let credit):
            self.label = credit
        case .CC_BY_SA_2_0(let credit):
            self.label = credit
        default:
            self.label = ""
        }
    }
    
    public var body: some View {
        NavigationLink {
            Group {
                switch licence {
                case .mit(let name, let author, let year):
                    MITLicence(name: name, year: year, author: author)
                case .apache(let name, let author, let year):
                    ApacheLicense(name: name, year: year, author: author)
                case .CC_BY_SA_2_0(let credit):
                    CC_BY_SA_2_0(credit: credit)
                case .CC0(let credit):
                    CC0(credit: credit)
                default:
                    EmptyView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text(label)
        }
    }
}

#endif
