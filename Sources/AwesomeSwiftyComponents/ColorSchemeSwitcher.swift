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
	private let systemLabel: LocalizedStringKey
	private let darkLabel: LocalizedStringKey
	private let lightLabel: LocalizedStringKey
	
	/// Creates a color scheme switcher.
	///
	/// - Parameters:
	///   - colorScheme: A binding to the selected ``PreferredColorScheme``.
	///   - showIcon: Whether to show an icon next to the picker.
	///   - hapticFeedback: Whether to trigger haptic feedback on selection changes.
	///   - systemLabel: The label used for the *System* option.
	///   - darkLabel: The label used for the *Dark* option.
	///   - lightLabel: The label used for the *Light* option.
    public init(colorScheme: Binding<PreferredColorScheme>, showIcon: Bool = true, hapticFeedback: Bool = true, systemLabel: LocalizedStringKey = "System", darkLabel: LocalizedStringKey = "Dark", lightLabel: LocalizedStringKey = "Light") {
        _colorScheme = colorScheme
        self.showIcon = showIcon
        self.hapticFeedback = hapticFeedback
        self.systemLabel = systemLabel
        self.darkLabel = darkLabel
        self.lightLabel = lightLabel
    }
    
    public var body: some View {
		let schemaSwitcher = Picker("Is Dark?", selection: $colorScheme.animation()) {
			Label(systemLabel, systemImage: "circle.lefthalf.filled")
                .tag(PreferredColorScheme.systemDefault)
			Label(darkLabel, systemImage: "circle.fill")
                .tag(PreferredColorScheme.dark)
			Label(lightLabel, systemImage: "circle")
                .tag(PreferredColorScheme.light)
        }
		#if !os(watchOS)
		.pickerStyle(.segmented)
		#endif
        .modifier(iOO17HapticFeedBack(feedbackTrigger: colorScheme))
        
        if(showIcon) {
            Label {
                schemaSwitcher
            } icon: {
                Image(systemName: colorScheme.icon)
                    .foregroundStyle(Color.accentColor)
                    .modifier(iOS17ContentTransition())
            }
        } else {
            schemaSwitcher
        }
    }
}

internal struct iOO17HapticFeedBack : ViewModifier {
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

internal struct iOS17ContentTransition : ViewModifier {
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
public enum PreferredColorScheme: String, CaseIterable {

	/// Always use light appearance.
	case light

	/// Always use dark appearance.
	case dark

	/// Follow the system appearance setting.
	case systemDefault

	/// The SF Symbol name associated with the color scheme.
	var icon: String {
		switch self {
		case .dark:
			return "moon.circle"
		case .light:
			return "sun.max.circle"
		case .systemDefault:
			return "circle.lefthalf.filled"
		}
	}

	/// The corresponding SwiftUI `ColorScheme` value.
	///
	/// Returns `nil` when the system appearance should be respected.
	public var mode: ColorScheme? {
		switch self {
		case .dark:
			return .dark
		case .light:
			return .light
		case .systemDefault:
			return nil
		}
	}
}
