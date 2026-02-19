import Foundation
import SwiftUI

/// A segmented control for selecting the app’s preferred color scheme.
///
/// This view is best used inside a `Form` or settings-style layout and provides
/// options for system default, light mode, and dark mode.
///
/// The selected value can be directly applied to a scene or view using
/// `.preferredColorScheme(_:)`.
///
/// ### How to Use
/// Define a variable to store the ``PreferredColorScheme``.
/// Use `@AppStorage` to persist the data over app launches.
/// ```swift
/// @AppStorage("colorScheme") private var scheme: PreferredColorScheme = .systemDefault
/// ```
/// Add the ColorSchemeSwitcher to your view. It looks best in a `Form`.
/// ```swift
/// Form {
///     ColorSchemeSwitcher(colorScheme: $scheme)
/// }
/// ```
/// This will look like this:
/// ![The ColorSchemeSwitcher in a Form](ColorSchemeSwitcher)
///
/// To apply the color schema, use the `.preferredColorScheme(_:)` modifier on a view.
/// ```swift
/// ContentView()
/// 	.preferredColorScheme(scheme.mode)
/// ```
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct ColorSchemeSwitcher: View {
    
    @Binding private var colorScheme: PreferredColorScheme
    private let showIcon: Bool
	private let hapticFeedback: Bool
	private let systemLabel: Text
	private let darkLabel: Text
	private let lightLabel: Text
	
	/// Creates a color scheme switcher.
	///
	/// - Parameters:
	///   - colorScheme: A binding to the selected ``PreferredColorScheme``.
	///   - showIcon: Whether to show an icon next to the picker.
	///   - hapticFeedback: Whether to trigger haptic feedback on selection changes.
	///   - systemLabel: The label used for the *System* option.
	///   - darkLabel: The label used for the *Dark* option.
	///   - lightLabel: The label used for the *Light* option.
    public init(colorScheme: Binding<PreferredColorScheme>, showIcon: Bool = true, hapticFeedback: Bool = true, systemLabel: Text? = nil, darkLabel: Text? = nil, lightLabel: Text? = nil) {
        _colorScheme = colorScheme
        self.showIcon = showIcon
        self.hapticFeedback = hapticFeedback
		self.systemLabel = systemLabel ?? Text("System", bundle: .module)
		self.darkLabel = darkLabel ?? Text("Dark", bundle: .module)
		self.lightLabel = lightLabel ?? Text("Light", bundle: .module)
    }
	
	private func getLabel(for schema: PreferredColorScheme) -> Text {
		switch schema {
			case .systemDefault: return systemLabel
			case .dark: return darkLabel
			case .light: return lightLabel
		}
	}
    
    public var body: some View {
		let schemaSwitcher = Picker(selection: $colorScheme.animation()) {
			ForEach(PreferredColorScheme.allCases) { schema in
				Label {
					getLabel(for: schema)
				} icon: {
					Image(systemName: schema.icon)
				}
			}
        } label: {
			Text("Color Scheme", bundle: .module)
		}
		#if !os(watchOS)
		.pickerStyle(.segmented)
		#endif
        .modifier(HapticFeedBackIfPossible(feedbackTrigger: colorScheme))
		.accessibilityValue(getLabel(for: colorScheme))
		.accessibilityHint(Text("Choose system, light, or dark appearance", bundle: .module))
        if(showIcon) {
            Label {
                schemaSwitcher
            } icon: {
                Image(systemName: colorScheme.icon)
                    .foregroundStyle(Color.accentColor)
                    .modifier(ContentTransitionIfPossible())
					.accessibilityHidden(true)
            }
        } else {
            schemaSwitcher
        }
    }
}

struct HapticFeedBackIfPossible : ViewModifier {
    let feedbackTrigger: PreferredColorScheme
    func body(content: Content) -> some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 26.0, *){
            content
                .contentTransition(.symbolEffect(.replace))
                .sensoryFeedback(.selection, trigger: feedbackTrigger)
        } else {
            content
        }
    }
}

struct ContentTransitionIfPossible : ViewModifier {
    func body(content: Content) -> some View {
		if #available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            content
                .contentTransition(.symbolEffect(.replace))
        } else {
            content
        }
    }
}

/// Represents the preferred appearance mode of the app.
public enum PreferredColorScheme: String, CaseIterable, Identifiable {
	public var id: Self { self }
	
	/// Follow the system appearance setting.
	case systemDefault
	/// Always use dark appearance.
	case dark
	/// Always use light appearance.
	case light

	/// The SF Symbol name associated with the color scheme.
	public var icon: String {
		switch self {
			case .dark: return "moon.circle"
			case .light: return "sun.max.circle"
			case .systemDefault: return "circle.lefthalf.filled"
		}
	}

	/// The corresponding SwiftUI `ColorScheme` value.
	///
	/// Returns `nil` when the system appearance should be respected.
	public var mode: ColorScheme? {
		switch self {
			case .dark: return .dark
			case .light: return .light
			case .systemDefault: return nil
		}
	}
}
