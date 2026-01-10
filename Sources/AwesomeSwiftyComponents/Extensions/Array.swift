import Foundation

extension Array: @retroactive RawRepresentable where Element: Codable {
    /// Creates an array from its raw string representation.
    ///
    /// This enables `Array` to conform to `RawRepresentable` when its elements are `Codable`,
    /// allowing you to store arrays in `@AppStorage` (and other string-backed storage) by
    /// automatically encoding/decoding JSON.
    ///
    /// Example:
    /// ```swift
    /// struct SettingsView: View {
    ///     @AppStorage("favoriteTags") private var favoriteTagsRaw: String = "[]"
    ///     private var favoriteTags: [String] {
    ///         get { Array<String>(rawValue: favoriteTagsRaw) ?? [] }
    ///         set { favoriteTagsRaw = newValue.rawValue }
    ///     }
    ///     var body: some View { Text("\(favoriteTags.count) tags") }
    /// }
    /// ```
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }

    /// A JSON string representing this array, suitable for storage in `@AppStorage`.
    ///
    /// Example:
    /// ```swift
    /// let numbers = [1, 2, 3]
    /// let stored = numbers.rawValue // "[1,2,3]"
    /// ```
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else { return "[]" }
        return result
    }
}
