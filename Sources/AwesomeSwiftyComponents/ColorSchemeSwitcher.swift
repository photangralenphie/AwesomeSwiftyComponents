import SwiftUI

/// A Color Scheme Switcher Best used in a ``SwiftUI/Form``form.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct ColorSchemeSwitcher: View {
    
    @Binding public var colorScheme: PreferredColorScheme
    private let showIcon: Bool
	private let hapticFeedback: Bool
	private let systemLabel: LocalizedStringKey
	private let darkLabel: LocalizedStringKey
	private let lightLabel: LocalizedStringKey
	
	/// Creates a color schema switcher.
	/// - Parameters:
	///   - colorScheme: A binding to a ``PreferredColorScheme``
	///   - showIcon: Whether to show an icon next to the picker (default: true).
	///   - hapticFeedback: Whether to use haptic feedback (default: true) [requires iOS 17].
	///   - systemLabel: The text to display on the `System`option (default: "System").
	///   - darkLabel: The text to display on the `Dark`option (default: "Dark").
	///   - lightLabel: The text to display on the `Light`option (default: "Light").
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

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
struct iOO17HapticFeedBack : ViewModifier {
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

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
struct iOS17ContentTransition : ViewModifier {
    func body(content: Content) -> some View {
		if #available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            content
                .contentTransition(.symbolEffect(.replace))
        } else {
            content
        }
    }
}

/// <#Description#>
public enum PreferredColorScheme: String, CaseIterable {
    case light
    case dark
    case systemDefault
    
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
	
	/// <#Description#>
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
