import Foundation

/// Adds the possibility to store Arrays with the `@AppStorage` wrapper.
extension Array: @retroactive RawRepresentable where Element: Codable {
    /// Adds the possibility to store Arrays with the `@AppStorage` wrapper.
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }

    /// Adds the possibility to store Arrays with the `@AppStorage` wrapper.
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else { return "[]" }
        return result
    }
}
