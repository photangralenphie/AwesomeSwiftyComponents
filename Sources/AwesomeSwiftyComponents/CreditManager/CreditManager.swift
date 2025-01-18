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
    case CC_BY_3_0(credit: String)
    case publicDomain(credit: String)
    
    public var description: String {
        switch self {
            case .mit(let name, let author, let year):
                return "MIT License"
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
            case .CC_BY_3_0(let credit):
                return "CC BY 3.0"
            case .publicDomain(let credit):
                return "Public Domain"
        }
    }
    
    public var creditEntity: String {
        switch self {
            case .mit(name: let name, author: let author, year: let year):
                return author
            case .apache(name: let name, author: let author, year: let year):
                return author
            case .CC0(credit: let credit):
                return credit
            case .CC_BY_SA_2_0(credit: let credit):
                return credit
            case .CC_BY_SA_3_0(credit: let credit):
                return credit
            case .CC_BY_SA_4_0(credit: let credit):
                return credit
            case .CC_BY_2_0(credit: let credit):
                return credit
            case .CC_BY_3_0(credit: let credit):
                return credit
            case .publicDomain(credit: let credit):
                return credit
        }
    }
}

public struct LicenceLink: View {
    
    private let licence: Licence
    private let name: String
    private let image: Image?
    
    public init(licence: Licence, image: Image? = nil) {
        self.licence = licence
        self.image = image
        
        switch licence {
            case .mit(let name, author: _, year: _):
                self.name = name
            case .apache(let name, author: _, year: _):
                self.name = name
            case .CC0(let credit):
                self.name = credit
            case .CC_BY_SA_2_0(let credit):
                self.name = credit
            case .CC_BY_SA_3_0(credit: let credit):
                self.name = credit
            case .CC_BY_SA_4_0(credit: let credit):
                self.name = credit
            case .CC_BY_2_0(credit: let credit):
                self.name = credit
            case .CC_BY_3_0(credit: let credit):
                self.name = credit
            case .publicDomain(credit: let credit):
                self.name = credit
        }
    }
    
    public var body: some View {
        NavigationLink {
            LicenceView(licence: licence)
        } label: {
            if let image {
                Label {
                    Text(name)
                        .padding(.leading)
                } icon: {
                    image
                        .frame(width: 50, height: 50)
                        .clipShape(.rect(cornerRadius: 5))
                        .padding(.leading)
                }
            } else {
                Text(name)
            }
        }
    }
}

public struct LicenceView: View {
    
    private let licence: Licence
    
    public init(licence: Licence) {
        self.licence = licence
    }
    
    public var body: some View {
        Group {
            switch licence {
                case .mit(let name, let author, let year):
                    MITLicense(name: name, year: year, author: author)
                case .apache(let name, let author, let year):
                    ApacheLicense(name: name, year: year, author: author)
                case .CC_BY_SA_2_0(let credit):
                    CC_BY_SA_2_0(credit: credit)
                case .CC0(let credit):
                    CC0(credit: credit)
                case .CC_BY_SA_3_0(credit: let credit):
                    CC_BY_SA_3_0(credit: credit)
                case .CC_BY_SA_4_0(credit: let credit):
                    CC_BY_SA_4_0(credit: credit)
                case .CC_BY_2_0(credit: let credit):
                    CC_BY_2_0(credit: credit)
                case .CC_BY_3_0(credit: let credit):
                    CC_BY_3_0(credit: credit)
                case .publicDomain(credit: let credit):
                    PublicDomain(credit: credit)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#endif
