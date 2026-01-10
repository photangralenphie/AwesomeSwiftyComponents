import SwiftUI

/// A navigable Credits form. Add ``LicenceLink``s to navigate to the corresponding licence.
///
/// Use `CreditManager` to show credits for your app.
/// The CreditManager works best when presented with a `.sheet()` or `.fullScreenCover()`.
///
/// The most common Open-Source Licences are already included. See ``Licence``.
///
/// ### Exemple
/// ```swift
/// Button("Show Credits") { isShowingCredits.toggle() }
///		.sheet(isPresented: $isShowingCredits) {
///			CreditManager {
/// 			LicenceLink(licence: .mit(name: "CodeScanner", author: "Paul Hudson", year: "2021"))
///			    LicenceLink(licence: .mit(name: "AwesomeSwiftyComponents", author: "Jonas Helmer", year: "2025"))
///			    LicenceLink(licence: .mit(name: "ShaderKit", author: "James Rochabrun", year: "2025"))
///			}
///		}
///```
/// The presented Sheet looks like this:
/// ![The presented CreditManager in a sheet.](CreditManager)
///
/// When navigated to a Licence it looks like this:
/// ![The Licence navigated to](CreditManagerLicence)
///
/// Use a ``LinkedCreditManager`` if you want to navigate to the CreditManager from within a `Form`, `List` or similar.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct CreditManager<Content: View>: View {
	@Environment(\.dismiss) private var dismiss
	
    @ViewBuilder public var content: Content
	let showCloseButton: Bool
	
	/// Creates a Credits container with the provided content.
	/// 
	/// - Parameter content: A view builder producing the rows and sections to display inside the Credits form.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
		self.showCloseButton = true
    }
	
	/// Creates a Credits container with the provided content.
	///
	/// - Parameter content: A view builder producing the rows and sections to display inside the Credits form.
	/// - Parameter showCloseButton: If to show the close button in the toolbar (default: true).
	public init(showCloseButton: Bool, @ViewBuilder content: () -> Content) {
		self.content = content()
		self.showCloseButton = showCloseButton
	}
        
    public var body: some View {
        NavigationStack {
            Form {
				content
            }
			.navigationTitle("Credits")
			.toolbar {
				if showCloseButton {
					ToolbarItem {
						Button("Close", systemImage: "xmark") { dismiss() }
					}
				}
			}
        }
    }
}

/// A navigable Credits form. Add ``LicenceLink``s to navigate to the corresponding licence.
///
/// Use `LinkedCreditManager` to show credits for your app.
/// The CreditManager works best when included in a Form with a `.sheet()` or `.fullScreenCover()`
///
/// The most common Open-Source Licences are already included. See ``Licence``.
///
/// ### Exemple
/// ```swift
/// Form {
///		Section("Legal"){
///			LinkedCreditManager {
/// 			LicenceLink(licence: .mit(name: "CodeScanner", author: "Paul Hudson", year: "2021"))
///			    LicenceLink(licence: .mit(name: "AwesomeSwiftyComponents", author: "Jonas Helmer", year: "2025"))
///			    LicenceLink(licence: .mit(name: "ShaderKit", author: "James Rochabrun", year: "2025"))
///			}
///		}
///	}
///```
/// The presented Sheet looks like this:
/// ![The presented LinkedCreditManager in a sheet.](LinkedCreditManager)
///
/// When navigated to the CreditManager is looks like this:
/// ![The presented CreditManager in a sheet.](CreditManager)
///
/// When navigated to a Licence it looks like this:
/// ![The Licence navigated to.](CreditManagerLicence)
///
/// Use a ``CreditManager`` if you want to present the CreditManager from a `.sheet()` or `.fullScreenCover()`.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct LinkedCreditManager<Content: View>: View {
    @ViewBuilder public var content: Content
    let text: LocalizedStringKey
    let systemImage: String
	
	/// Creates a navigation link to a Credits screen.
	///
	/// - Parameters:
	///   - text: The localized title for the link label. Defaults to "Credits".
	///   - systemImage: The SF Symbol name to display with the label. Defaults to `"text.document.fill"`.
	///   - content: A view builder producing the rows and sections to show inside the destination `CreditManager`.
    public init(text: LocalizedStringKey = "Credits", systemImage: String = "text.document.fill", @ViewBuilder content: () -> Content) {
        self.content = content()
        self.text = text
        self.systemImage = systemImage
    }
    
    public var body: some View {
        NavigationLink {
            CreditManager(showCloseButton: false) {
                content
            }
        } label: {
            Label(text, systemImage: systemImage)
        }
    }
}

/// A set of supported license and attribution types for credits.
///
/// Each case carries the associated data needed to present a human-readable
/// description and unique identifier. Use this type to model the license or
/// attribution required for an asset or dependency.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public enum Licence: Identifiable {
    case mit(name: String, author: String, year: String)
    case apache(name: String, author: String, year: String)
    case CC0(credit: String)
    case CC_BY_2_0(credit: String)
    case CC_BY_3_0(credit: String)
    case CC_BY_SA_2_0(credit: String)
    case CC_BY_SA_3_0(credit: String)
    case CC_BY_SA_4_0(credit: String)
    case publicDomain(credit: String)
    case photographerAttribution(name: String)
	
	/// A stable identifier derived from the case and its associated values.
	public var id: String {
		switch self {
			case let .mit(name, author, year):
				return "mit-\(name)-\(author)-\(year)"
			case let .apache(name, author, year):
				return "apache-\(name)-\(author)-\(year)"
			case let .CC0(credit):
				return "cc0-\(credit)"
			case let .CC_BY_2_0(credit):
				return "ccby20-\(credit)"
			case let .CC_BY_3_0(credit):
				return "ccby30-\(credit)"
			case let .CC_BY_SA_2_0(credit):
				return "ccbysa20-\(credit)"
			case let .CC_BY_SA_3_0(credit):
				return "ccbysa30-\(credit)"
			case let .CC_BY_SA_4_0(credit):
				return "ccbysa40-\(credit)"
			case let .publicDomain(credit):
				return "publicdomain-\(credit)"
			case let .photographerAttribution(name):
				return "photographer-\(name)"
		}
	}
	
	/// A human-readable description of the license or attribution type.
    public var description: String {
        switch self {
			case .mit(_, _, _):
                return "MIT License"
			case .apache(_, _, _):
                return "Apache License V2.0"
            case .CC0(_):
                return "CC0"
            case .CC_BY_SA_2_0(_):
                return "CC BY SA 2.0"
            case .CC_BY_SA_3_0(_):
                return "CC BY SA 3.0"
            case .CC_BY_SA_4_0(_):
                return "CC BY SA 4.0"
            case .CC_BY_2_0(_):
                return "CC BY 2.0"
            case .CC_BY_3_0(_):
                return "CC BY 3.0"
            case .publicDomain(_):
                return "Public Domain"
            case .photographerAttribution(name: _):
                return "All Rights Reserved"
        }
    }
	
	/// The primary credited entity for this license, such as the author or name.
    public var creditEntity: String {
        switch self {
            case .mit(name: _, author: let author, year: _):
                return author
            case .apache(name: _, author: let author, year: _):
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
            case .photographerAttribution(name: let name):
                return name
        }
    }
}

/// A navigation link row that presents details for a specific license.
///
/// The preferred use is from a  ``CreditManager`` or ``LinkedCreditManager``,  the `LicenceLink` can also be used separately.
///
/// The most common Open-Source Licences are already included. See ``Licence``.
///
/// ### Example with ``CreditManager``
/// ```swift
/// Button("Show Credits") { isShowingCredits.toggle() }
///		.sheet(isPresented: $isShowingCredits) {
///			CreditManager {
/// 			LicenceLink(licence: .mit(name: "CodeScanner", author: "Paul Hudson", year: "2021"))
///			    LicenceLink(licence: .mit(name: "AwesomeSwiftyComponents", author: "Jonas Helmer", year: "2025"))
///			    LicenceLink(licence: .mit(name: "ShaderKit", author: "James Rochabrun", year: "2025"))
///			}
///		}
///```
/// The presented Sheet looks like this:
/// ![The presented CreditManager in a sheet.](CreditManager)
///
/// When navigated to a Licence it looks like this:
/// ![The Licence navigated to](CreditManagerLicence)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct LicenceLink: View {
    
    private let licence: Licence
    private let name: String
    private let image: Image?
	
	/// Creates a link row for the given license.
	///
	/// - Parameters:
	///   - licence: The `Licence` to display and navigate to.
	///   - image: An optional `Image` to show as an icon alongside the license name.
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
            case .photographerAttribution(name: let name):
                self.name = name
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
						.clipShape(.rect(cornerRadius: 10, style: .continuous))
                        .padding(.leading)
                }
            } else {
                Text(name)
            }
        }
    }
}

/// A detailed view that renders the full text or attribution for a license.
///
/// `LicenceView` chooses an appropriate subview based on the `Licence`
/// case, such as MIT or Apache license text, Creative Commons attributions,
/// or photographer credits.
///
/// The preferred use is from a  ``LicenceLink``, but  it can also be used separately.
///
/// The most common Open-Source Licences are already included. See ``Licence``.
///
/// ### Example with ``LicenceLink``
/// ```swift
/// LicenceLink(licence: .mit(name: "AwesomeSwiftyComponents", author: "Jonas Helmer", year: "2025"))
///```
///
/// When navigated to a Licence it looks like this:
/// ![The Licence navigated to](CreditManagerLicence)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0,*)
public struct LicenceView: View {
    
    private let licence: Licence
	
	/// Creates a detailed license view.
	///
	/// - Parameter licence: The license or attribution to display.
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
                case .photographerAttribution(name: let name):
                    Form {
                        Text("Image by \(name)")
                        Text("All rights reserved.")
                    }
            }
        }
		#if !os(macOS) && !os(tvOS)
        .navigationBarTitleDisplayMode(.inline)
		#endif
    }
}
