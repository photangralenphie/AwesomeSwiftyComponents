import SwiftUI

@available(iOS 15.0, *)
public struct ColorSchemeSwitcher: View {
    
    @Binding public var colorScheme: PreferredColorScheme
    @State public var showIcon: Bool
    
    public init(colorScheme: Binding<PreferredColorScheme>, showIcon: Bool) {
        _colorScheme = colorScheme
        self.showIcon = showIcon
    }
    
    public var body: some View {
        HStack {
            Image(systemName: colorScheme.icon())
                .foregroundStyle(Color.accentColor)
                .modifier(iOS17Stuff(feedbackTrigger: colorScheme))
            Picker("Is Dark?", selection: $colorScheme) {
                Text("System")
                    .tag(PreferredColorScheme.systemDefault)
                Text("Dark")
                    .tag(PreferredColorScheme.dark)
                Text("Light")
                    .tag(PreferredColorScheme.light)
            }
            .pickerStyle(.segmented)
        }
    }
}

fileprivate struct iOS17Stuff : ViewModifier {
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

public enum PreferredColorScheme: String, CaseIterable {
    case light
    case dark
    case systemDefault
    
    fileprivate func icon() -> String {
        switch self {
            case .dark:
                return "moon.circle"
            case .light:
                return "sun.max.circle"
            case .systemDefault:
                return "circle.lefthalf.filled"
        }
    }
    
    public func mode() -> ColorScheme? {
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
