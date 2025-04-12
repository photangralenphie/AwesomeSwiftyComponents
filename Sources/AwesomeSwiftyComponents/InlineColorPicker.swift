import SwiftUI

/// An  awesome, simple but customizable Inline color picker. Supports saving a color with `@AppStorage`.  You can provide your own colors by implementing a type conforming to ``ColorOptions``.
///
/// ## Essentials
/// Get started by defining a `@State` variable to hold you selected color.
/// This can either be an on of the enum ``AvailableColors`` or your own implemented color selection conforming to the ``ColorOptions`` protocol:
/// ```swift
/// @State private var myColor: AvailableColors = .blue
/// ```
/// If you want to persist the state over restarts (e.g. for tint/accentColors), use `@AppStorage`:
/// ```swift
/// @AppStorage("myColor") private var myColor: AvailableColors = .blue
/// ```
/// Add the piker to your `View` and bind you defined variable to it:
/// ```swift
/// InlineColorPicker(selectedColor: $myColor)
/// ```
/// The picker looks best, if you make it a child of a `Form` or `List`
///
/// ### Using the selected Color
/// To use the selected, use the ``ColorOptions/SwiftUIColor`` property:
/// ```swift
///  MyView()
///     .tint(myColor.SwiftUIColor)
/// ```
///
/// ### Styles & Customization
/// The picker supports two different style: ``InlineColorPickerStyle/slim`` which is set as the default and ``InlineColorPickerStyle/expanded(systemImage:description:)``.
///  ```swift
/// InlineColorPicker(selectedColor: $myColor, pickerStyle: .expanded())
/// ```
///
/// You can customize the SF Symbol and the text in the picker like this:
///  ```swift
/// InlineColorPicker(selectedColor: $myColor, pickerStyle: .expanded(systemImage: "paintbrush.pointed", description: "Selected Color:"))
/// ```
@available(iOS 15.0, *)
@available(macOS 14, *)
public struct InlineColorPicker<T: ColorOptions>: View {
    
    /// The selected color wrapper. Binding to a variable of type ``AvailableColors`` or you own type which conforms to ``ColorOptions``.
    var selectedColor: Binding<T>
    /// The style of the picker.
    let pickerStyle: InlineColorPickerStyle
    
    private let enumType: any ColorOptions.Type
    
    
    /// Creates a new ``InlineColorPicker``.
    /// - Parameters:
    ///   - selectedColor: The selected color wrapper. Binding to a variable of type ``AvailableColors`` or you own type which conforms to ``ColorOptions``.
    ///   - pickerStyle: The style of the picker (default: ``InlineColorPickerStyle/slim``) .
    public init(selectedColor: Binding<T>, pickerStyle: InlineColorPickerStyle = .slim) {
        self.selectedColor = selectedColor
        self.pickerStyle = pickerStyle
        
        self.enumType = type(of: selectedColor.wrappedValue)
    }
    
    public var body: some View {
        VStack {
            switch pickerStyle {
                case .expanded(let systemImage, let description):
                    HStack {
                        Label(description, systemImage: systemImage)
                        Spacer()
                        Text(selectedColor.wrappedValue.SwiftUIColor.description.capitalized)
                            .foregroundColor(selectedColor.wrappedValue.SwiftUIColor)
                    }
                default: EmptyView()
            }

            HStack {
                let colors = Array(enumType.allCases.compactMap { $0 as? T })
                ForEach(colors.indices, id: \.self) { colorIndex in
                    Circle()
                        .strokeBorder(selectedColor.wrappedValue == colors[colorIndex] ? Color.gray : colors[colorIndex].SwiftUIColor , lineWidth: 3)
                        .background {
                            if colors[colorIndex].SwiftUIColor == Color.primary {
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
    
    private func elementAt<T: Collection>(from collection: T, index: T.Index) -> T.Element? {
        guard collection.indices.contains(index) else {
            return nil
        }
        return collection[index]
    }
}

@available(iOS 15.0, *)
@available(macOS 14, *)
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

/// Available styles for the ``InlineColorPicker``
@available(iOS 15.0, *)
@available(macOS 14, *)
public enum InlineColorPickerStyle {
    /// The slim style for the ``InlineColorPicker``.
    case slim
    /// The expanded style for the ``InlineColorPicker``.
    /// - Parameters:
    ///     - systemImage: The SF Symbol to display int the `.topLeading` corner of the picker (default: `paintbrush`).
    ///     - description: The text to display in the `.topTrailing` corner of the picker (default: Accent Color:)
    case expanded(systemImage: String = "paintbrush", description: LocalizedStringKey = "Accent Color:")
}

/// A default type, which can be used to bind the selected color for an ``InlineColorPicker``.
@available(iOS 15.0, *)
@available(macOS 14, *)
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
    
    
    /// Returns the `Color` for an variable of type ``AvailableColors``.
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
}


/// Use this to implement you own collection of colors for the ``InlineColorPicker``.
///
/// An Enum conforming to this protocol works best:
///  - Create a new enum and make if conform to ``ColorOptions`` (see an example below).
///  - Create a `@State` variable of you new type.
///  - Bind it to the ``InlineColorPicker`` and your picker will display only your selected Colors
///  - You can also use ``AvailableColors`` which also conforms to this protocol the use the standard colors.
/// ```swift
///public enum WarmColors: Int, ColorOptions {
///    case yellow = 1
///    case orange = 2
///    case red = 3
///
///    public var SwiftUIColor: Color {
///        switch self {
///        case .yellow:
///            return .yellow
///        case .orange:
///            return .orange
///        case .red:
///            return .red
///        }
///    }
///
///    public func hash(into hasher: inout Hasher) {
///        hasher.combine(self.rawValue)
///    }
///}
/// ```
@available(macOS 14, *)
public protocol ColorOptions: CaseIterable, Hashable {
    var SwiftUIColor: Color { get }
}
