import Foundation

/// Generates an `@Observable`-compatible computed property backed by `UserDefaults`.
///
/// The generated property uses `access(keyPath:)` and `withMutation(keyPath:)` so
/// reads and writes participate in Observation tracking.
///
/// Use this overload when the `UserDefaults` key and Swift property name differ.
///
/// - Parameters:
///   - key: The `UserDefaults` key to read from and write to.
///   - variableName: The generated Swift property name.
///   - type: The generated property type (for example `String.self`).
///   - defaultValue: The value returned when no value exists in `UserDefaults`.
///
/// ## Example
/// ```swift
/// @Observable
/// final class SettingsModel {
///     #ObservableAppStorage(key: "paper_type", variableName: "paperType", type: String.self, defaultValue: "a4")
/// }
/// ```
@freestanding(declaration, names: arbitrary)
public macro ObservableAppStorage(key: String, variableName: String, type: Any.Type, defaultValue: Any) = #externalMacro(module: "AwesomeSwiftyComponentsMacros", type: "ObservableAppStorageMacro")

/// Generates an `@Observable`-compatible computed property backed by `UserDefaults`.
///
/// Use this overload when the `UserDefaults` key and Swift property name are identical.
///
/// - Parameters:
///   - key: The `UserDefaults` key and generated Swift property name.
///   - type: The generated property type (for example `String.self`).
///   - defaultValue: The value returned when no value exists in `UserDefaults`.
///
/// ## Example
/// ```swift
/// @Observable
/// final class SettingsModel {
///     #ObservableAppStorage("paperType", type: String.self, defaultValue: "a4")
/// }
/// ```
@freestanding(declaration, names: arbitrary)
public macro ObservableAppStorage(_ key: String, type: Any.Type, defaultValue: Any) = #externalMacro(module: "AwesomeSwiftyComponentsMacros", type: "ObservableAppStorageMacro")
