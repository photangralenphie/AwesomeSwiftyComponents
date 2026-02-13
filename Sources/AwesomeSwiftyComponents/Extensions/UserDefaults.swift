import Foundation

/// Convenience APIs used by ``ObservableAppStorage(key:variableName:type:defaultValue:)`` and
/// ``ObservableAppStorage(_:type:defaultValue:)`` to persist strongly typed values in `UserDefaults`.
///
/// The `ObservableAppStorage` macro generates properties that call these helpers in their
/// `get` and `set` accessors.
///
/// ## Example: Macro generated persistence
/// ```swift
/// @Observable
/// final class SettingsModel {
///     #ObservableAppStorage("paperType", type: String.self, defaultValue: "a4")
///     #ObservableAppStorage(key: "accent", variableName: "accent", type: PreferredColorScheme.self, defaultValue: .systemDefault)
/// }
/// ```
///
/// ## Example: Direct usage without the macro
/// ```swift
/// let key = "paperType"
/// let current = UserDefaults.getValue(key, "a4")
/// UserDefaults.setValue(key, "letter")
/// ```
extension UserDefaults {
	
	// MARK: - Getter
	/// Returns a persisted `Bool` for `key` or `defaultValue` if no value exists.
	public static func getValue(_ key: String, _ defaultValue: Bool) -> Bool {
		UserDefaults.standard.bool(forKey: key)
	}
	
	/// Returns a persisted `Int` for `key` or `defaultValue` if no value exists.
	public static func getValue(_ key: String, _ defaultValue: Int) -> Int {
		UserDefaults.standard.integer(forKey: key) ?? defaultValue
	}
	
	/// Returns a persisted `Float` for `key` or `defaultValue` if no value exists.
	public static func getValue(_ key: String, _ defaultValue: Float) -> Float {
		UserDefaults.standard.float(forKey: key) ?? defaultValue
	}
	
	/// Returns a persisted `Double` for `key` or `defaultValue` if no value exists.
	public static func getValue(_ key: String, _ defaultValue: Double) -> Double {
		UserDefaults.standard.double(forKey: key) ?? defaultValue
	}
	
	/// Returns a persisted `URL` for `key` or `defaultValue` if no value exists.
	public static func getValue(_ key: String, _ defaultValue: URL) -> URL {
		UserDefaults.standard.url(forKey: key) ?? defaultValue
	}
	
	/// Returns a persisted `String` for `key` or `defaultValue` if no value exists.
	public static func getValue(_ key: String, _ defaultValue: String) -> String {
		UserDefaults.standard.string(forKey: key) ?? defaultValue
	}
	
	/// Returns a persisted `[String]` for `key` or `defaultValue` if no value exists.
	public static func getValue(_ key: String, _ defaultValue: [String]) -> [String] {
		UserDefaults.standard.stringArray(forKey: key) ?? defaultValue
	}
	
	/// Returns persisted `Data` for `key` or `defaultValue` if no value exists.
	public static func getValue(_ key: String, _ defaultValue: Data) -> Data {
		UserDefaults.standard.data(forKey: key) ?? defaultValue
	}
	
	/// Returns a persisted array for `key` or `defaultValue` if no value exists.
	public static func getValue<T>(_ key: String, _ defaultValue: [T]) -> [T] where T: SupportedObservableUserDefaultTypes {
		UserDefaults.standard.array(forKey: key) as? [T] ?? defaultValue
	}
	
	/// Returns a persisted dictionary for `key` or `defaultValue` if no value exists.
	public static func getValue<T>(_ key: String, _ defaultValue: [String: T]) -> [String: T] where T: SupportedObservableUserDefaultTypes {
		UserDefaults.standard.dictionary(forKey: key) as? [String: T] ?? defaultValue
	}
	
	/// Returns a persisted `RawRepresentable` value for `key` or `defaultValue` if no value exists.
	public static func getValue<T>(_ key: String, _ defaultValue: T) -> T where T: RawRepresentable, T.RawValue: SupportedObservableUserDefaultTypes {
		guard let rawValue = UserDefaults.standard.object(forKey: key) as? T.RawValue else { return defaultValue }
		return T(rawValue: rawValue) ?? defaultValue
	}
	
	// MARK: - Setter
	/// Persists a supported value under `key`.
	public static func setValue<T>(_ key: String, _ value: T) where T: SupportedObservableUserDefaultTypes {
		UserDefaults.standard.set(value, forKey: key)
	}
	
	/// Persists a supported array under `key`.
	public static func setValue<T>(_ key: String, _ value: [T]) where T: SupportedObservableUserDefaultTypes {
		UserDefaults.standard.set(value, forKey: key)
	}
	
	/// Persists a supported dictionary under `key`.
	public static func setValue<T>(_ key: String, _ value: [String: T]) where T: SupportedObservableUserDefaultTypes {
		UserDefaults.standard.set(value, forKey: key)
	}
	
	/// Persists a `RawRepresentable` value's `rawValue` under `key`.
	public static func setValue<T>(_ key: String, _ newValue: T) where T: RawRepresentable, T.RawValue: SupportedObservableUserDefaultTypes {
		UserDefaults.standard.set(newValue.rawValue, forKey: key)
	}
}

/// Marker protocol for value types that can be read/written by `ObservableAppStorage`.
public protocol SupportedObservableUserDefaultTypes {}

extension String: SupportedObservableUserDefaultTypes {}
extension Bool: SupportedObservableUserDefaultTypes {}
extension Int: SupportedObservableUserDefaultTypes {}
extension Double: SupportedObservableUserDefaultTypes {}
extension Float: SupportedObservableUserDefaultTypes {}
extension Data: SupportedObservableUserDefaultTypes {}
extension URL: SupportedObservableUserDefaultTypes {}
