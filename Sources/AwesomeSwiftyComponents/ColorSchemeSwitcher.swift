import SwiftUI

@available(iOS 15.0, *)
@available(macOS 14, *)
public struct ColorSchemeSwitcher: View {
    
    @Binding public var colorScheme: PreferredColorScheme
    let showIcon: Bool
    let hapticFeedback: Bool
    let systemLabel: String
    let darkLabel: String
    let lightLabel: String
    
    public init(colorScheme: Binding<PreferredColorScheme>, showIcon: Bool = true, hapticFeedback: Bool = true, systemLabel: String = "System", darkLabel: String = "Dark", lightLabel: String = "Light") {
        _colorScheme = colorScheme
        self.showIcon = showIcon
        self.hapticFeedback = hapticFeedback
        self.systemLabel = systemLabel
        self.darkLabel = darkLabel
        self.lightLabel = lightLabel
    }
    
    public var body: some View {
        let schemaSwitcher = Picker("Is Dark?", selection: $colorScheme) {
            Text(systemLabel)
                .tag(PreferredColorScheme.systemDefault)
            Text(darkLabel)
                .tag(PreferredColorScheme.dark)
            Text(lightLabel)
                .tag(PreferredColorScheme.light)
        }
        .pickerStyle(.segmented)
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

@available(macOS 14, *)
fileprivate struct iOO17HapticFeedBack : ViewModifier {
    let feedbackTrigger: PreferredColorScheme
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .contentTransition(.symbolEffect(.replace))
                .sensoryFeedback(.selection, trigger: feedbackTrigger)
        } else {
            content
        }
    }
}

@available(macOS 14, *)
fileprivate struct iOS17ContentTransition : ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .contentTransition(.symbolEffect(.replace))
        } else {
            content
        }
    }
}

@available(macOS 10.15, *)
public enum PreferredColorScheme: String, CaseIterable {
    case light
    case dark
    case systemDefault
    
    fileprivate var icon: String {
        switch self {
            case .dark:
                return "moon.circle"
            case .light:
                return "sun.max.circle"
            case .systemDefault:
                return "circle.lefthalf.filled"
        }
    }
    
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
