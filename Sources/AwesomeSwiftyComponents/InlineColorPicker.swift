import SwiftUI

@available(iOS 15.0, *)
public struct InlineColorPicker<T: ColorOptions>: View {
    
    var selectedColor: Binding<T>
    
    let pickerStyle: ColorPickerStyle
    let systemImage: String
    let description: LocalizedStringKey
    
    private let enumType: any ColorOptions.Type
    
    public init(selectedColor: Binding<T>, pickerStyle: ColorPickerStyle = .slim, systemImage: String = "paintbrush", description: LocalizedStringKey = "Accent Color:") {
        self.selectedColor = selectedColor
        self.pickerStyle = pickerStyle
        self.systemImage = systemImage
        self.description = description
        
        self.enumType = type(of: selectedColor.wrappedValue)
    }
    
    public var body: some View {
        VStack {
            if pickerStyle == .expanded {
                HStack {
                    Label(description, systemImage: systemImage)
                    Spacer()
                    Text(selectedColor.wrappedValue.SwiftUIColor.description.capitalized)
                        .foregroundColor(selectedColor.wrappedValue.SwiftUIColor)
                }
            }

            HStack {
                let colors = Array(enumType.allCases.compactMap { $0 as? T })
                ForEach(colors.indices, id: \.self) { colorIndex in
                    Circle()
                        .strokeBorder(selectedColor.wrappedValue == colors[colorIndex] ? Color.gray : colors[colorIndex].SwiftUIColor , lineWidth: 3)
                        .background {
                            if (colors[colorIndex].IsPrimaryColor()) {
                                Image(systemName: "circle.righthalf.fill")
                                    .imageScale(.large)
                            } else {
                                Circle().foregroundColor(colors[colorIndex].SwiftUIColor)
                            }
                        }
                        .padding(.horizontal, -13)
                        .onTapGesture {
                            selectedColor.wrappedValue = colors[colorIndex]
                        }
                }
            }
        }
        .padding(.vertical, 7)
        .modifier(Feedback(color: selectedColor.wrappedValue.SwiftUIColor))
    }
    
    func elementAt<T: Collection>(from collection: T, index: T.Index) -> T.Element? {
        guard collection.indices.contains(index) else {
            return nil
        }
        return collection[index]
    }
}

@available(iOS 15.0, *)
fileprivate struct Feedback: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .sensoryFeedback(.selection, trigger: color)
        } else {
            content
        }
    }
}

@available(iOS 15.0, *)
public enum ColorPickerStyle {
    case slim, expanded
}

import SwiftUI

@available(iOS 15.0, *)
public enum AvailableColors: Int, ColorOptions, Codable {
    case blue = 0
    case cyan = 1
    case mint = 2
    case green = 3
    case yellow = 4
    case orange = 5
    case red = 6
    case purple = 7
    case indigo = 8
    case primary = 9
    
    public var SwiftUIColor: Color {
        switch self {
        case .blue:
            return .blue
        case .cyan:
            return .cyan
        case .mint:
            return .mint
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .orange:
            return .orange
        case .red:
            return .red
        case .purple:
            return .purple
        case .indigo:
            return .indigo
        case .primary:
            return .primary
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
    
    public func IsPrimaryColor() -> Bool {
        return self == .primary
    }
}


public protocol ColorOptions: CaseIterable, Hashable {
    var SwiftUIColor: Color { get }
    func IsPrimaryColor() -> Bool
}
