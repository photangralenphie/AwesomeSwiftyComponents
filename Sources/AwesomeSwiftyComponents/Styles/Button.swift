import SwiftUI

// MARK: - iOSBorderedForMacOS

/// A button style that mimics the iOS `.bordered` button appearance on macOS.
///
/// This style exists to visually align macOS buttons with iOS when sharing
/// design language across platforms.
/// Applying this style has **no effect outside macOS** and does not alter
/// the system button style on iOS.
@available(macOS 12.0, *)
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct iOSBorderedForMacOS<S: Shape>: ButtonStyle {

	/// The foreground color used for the button’s label.
	let foregroundColor: Color

	/// The shape used to clip the button background.
	let clipShape: S

	/// Creates a bordered button style matching iOS appearance on macOS.
	///
	/// - Parameters:
	///   - foregroundColor: The color applied to the button label.
	///   - clipShape: The shape used to clip the button’s background.
	///
	/// ### Example
	/// ```swift
	/// Button("Add", action: addItem)
	///     .buttonStyle(iOSBorderedForMacOS())
	/// ```
	public init(
		foregroundColor: Color = .primary,
		clipShape: S = Circle()
	) {
		self.foregroundColor = foregroundColor
		self.clipShape = clipShape
	}

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
		#if os(macOS)
			.foregroundStyle(foregroundColor)
			.padding(6)
			.background(
				Color.secondary
					.overlay {
						Color.clear.background(.regularMaterial)
					}
			)
			.clipShape(clipShape)
		#endif
	}
}

// MARK: - iOSBorderedProminentForMacOS

/// A button style that mimics the iOS `.borderedProminent` appearance on macOS.
///
/// This style is intended for primary actions and mirrors the visual weight
/// and emphasis of iOS prominent buttons.
/// It only applies on macOS and is ignored on other platforms.
@available(macOS 12.0, *)
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct iOSBorderedProminentForMacOS<S: Shape>: ButtonStyle {

	/// The shape used to clip the button background.
	let clipShape: S

	/// Creates a prominent bordered button style matching iOS appearance on macOS.
	///
	/// - Parameter clipShape: The shape used to clip the button’s background.
	///
	/// ### Example
	/// ```swift
	/// Button("Save", action: save)
	///     .buttonStyle(iOSBorderedProminentForMacOS())
	/// ```
	public init(
		clipShape: S = RoundedRectangle(cornerRadius: 7)
	) {
		self.clipShape = clipShape
	}

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
		#if os(macOS)
			.foregroundStyle(.foreground)
			.padding(6)
			.background(Color.accentColor)
			.clipShape(clipShape)
		#endif
	}
}
