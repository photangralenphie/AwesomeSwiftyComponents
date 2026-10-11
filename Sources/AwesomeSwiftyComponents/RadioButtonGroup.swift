//
//  RadioButtonGroup.swift
//  AwesomeSwiftyComponents
//
//  Created by Jonas Helmer on 11.10.26.
//

//
// Copyright © 2026 MyMedia.
// Licensed under the MIT License.
//

import SwiftUI

#if canImport(AppKit)

/// Defines the horizontal spacing distribution of items within an ``IconRadioGroup``.
@available(macOS 10.15, *)
public enum RadioGroupDistribution: Equatable {
	/// Distributes items evenly across the available horizontal space, including equal spacing before the first item and after the last item.
	case spaceEvenly
	/// Distributes items with equal spacing between each adjacent pair, with no extra spacing at the outer leading and trailing edges.
	case spaceBetween
}

/// A protocol representing an item displayed in an ``IconRadioGroup``.
///
/// Types conforming to this protocol provide an SF Symbol icon name and a display title.
///
/// ### Example
/// ```swift
/// enum AlignmentOption: String, CaseIterable, IconRadioGroupItem {
///     case leading
///     case center
///     case trailing
///
///     public var id: Self { self }
///
///     var title: String {
///         rawValue.capitalized
///     }
///
///     var icon: String {
///         switch self {
///         case .leading: return "text.alignleft"
///         case .center: return "text.aligncenter"
///         case .trailing: return "text.alignright"
///         }
///     }
/// }
/// ```
@available(macOS 10.15, *)
public protocol IconRadioGroupItem: Hashable, Equatable {
	/// The SF Symbol name representing the item icon.
	var icon: String { get }
	/// The title displayed above the icon.
	var title: String { get }
}

/// A macOS radio button group that displays selectable items arranged horizontally with titles, SF Symbol icons, and radio buttons.
///
/// Clicking either the radio button or the entire item column selects the corresponding option.
///
/// ### How to Use
/// 1. Define an item type conforming to ``IconRadioGroupItem``:
/// ```swift
/// enum AlignmentOption: String, CaseIterable, IconRadioGroupItem {
///     case leading
///     case center
///     case trailing
///
///     public var id: Self { self }
///
///     var title: String {
///         rawValue.capitalized
///     }
///
///     var icon: String {
///         switch self {
///         case .leading: return "text.alignleft"
///         case .center: return "text.aligncenter"
///         case .trailing: return "text.alignright"
///         }
///     }
/// }
/// ```
///
/// 2. Add the radio group to your SwiftUI view hierarchy:
/// ```swift
/// struct SettingsView: View {
///     @State private var selectedAlignment: AlignmentOption = .center
///
///     var body: some View {
///         IconRadioGroup(
///             selection: $selectedAlignment,
///             distribution: .spaceEvenly,
///             items: AlignmentOption.allCases
///         )
///         .frame(width: 320, height: 100)
///     }
/// }
/// ```
@available(macOS 10.15, *)
public struct IconRadioGroup<Value: IconRadioGroupItem>: NSViewRepresentable {
	/// A binding to the currently selected item.
	@Binding public var selection: Value
	/// The spacing distribution style used between the items in the horizontal stack.
	public var distribution: RadioGroupDistribution = .spaceEvenly
	/// The list of items displayed in the radio group.
	public let items: [Value]

	/// Creates an icon radio group with the specified selection binding, distribution, and items.
	///
	/// - Parameters:
	///   - selection: A binding to the currently selected item.
	///   - distribution: The layout distribution of items across the group. Defaults to `.spaceEvenly`.
	///   - items: An array of items conforming to ``IconRadioGroupItem`` to display.
	public init(
		selection: Binding<Value>,
		distribution: RadioGroupDistribution = .spaceEvenly,
		items: [Value]
	) {
		self._selection = selection
		self.distribution = distribution
		self.items = items
	}

	public func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	public func makeNSView(context: Context) -> NSStackView {
		let stack = NSStackView()
		stack.orientation = .horizontal
		stack.alignment = .centerY
		stack.distribution = .fill
		stack.spacing = 0
		
		var spacers: [NSView] = []
		if distribution == .spaceEvenly {
			spacers.append(addSpacer(to: stack))
		}
		
		for (index, item) in items.enumerated() {
			let title = NSTextField(labelWithString: item.title)
			title.alignment = .center
			title.maximumNumberOfLines = 1
			title.cell?.wraps = false
			title.cell?.usesSingleLineMode = true
			title.cell?.lineBreakMode = .byTruncatingTail
			title.setContentCompressionResistancePriority(.required, for: .horizontal)
			
			let symbol = NSImageView()
			let configuration = NSImage.SymbolConfiguration(pointSize: 30, weight: .regular)
			symbol.image = NSImage(systemSymbolName: item.icon, accessibilityDescription: item.title)?
				.withSymbolConfiguration(configuration)
			symbol.contentTintColor = .controlAccentColor
			symbol.imageScaling = .scaleProportionallyUpOrDown
			symbol.translatesAutoresizingMaskIntoConstraints = false
			symbol.widthAnchor.constraint(equalToConstant: 36).isActive = true
			symbol.heightAnchor.constraint(equalToConstant: 36).isActive = true
			
			let radio = NSButton(
				radioButtonWithTitle: "",
				target: context.coordinator,
				action: #selector(Coordinator.selectionChanged(_:))
			)
			radio.state = item == selection ? .on : .off
			radio.alignment = .center
			radio.setContentHuggingPriority(.required, for: .horizontal)
			radio.setContentCompressionResistancePriority(.required, for: .horizontal)
			radio.setAccessibilityLabel(item.title)
			
			let itemStack = NSStackView(views: [title, symbol, radio])
			itemStack.orientation = .vertical
			itemStack.alignment = .centerX
			itemStack.spacing = 6
			itemStack.setHuggingPriority(.defaultHigh, for: .horizontal)
			itemStack.setContentCompressionResistancePriority(.required, for: .horizontal)
			
			context.coordinator.values[ObjectIdentifier(radio)] = item
			context.coordinator.values[ObjectIdentifier(itemStack)] = item
			let clickRecognizer = NSClickGestureRecognizer(
				target: context.coordinator,
				action: #selector(Coordinator.itemClicked(_:))
			)
			itemStack.addGestureRecognizer(clickRecognizer)
			stack.addArrangedSubview(itemStack)
			
			if index < items.count - 1 {
				spacers.append(addSpacer(to: stack))
			}
		}
		
		if distribution == .spaceEvenly {
			spacers.append(addSpacer(to: stack))
		}
		
		if let firstSpacer = spacers.first {
			for spacer in spacers.dropFirst() {
				spacer.widthAnchor.constraint(equalTo: firstSpacer.widthAnchor).isActive = true
			}
		}
		
		return stack
	}

	public func updateNSView(_ stack: NSStackView, context: Context) {
		context.coordinator.parent = self
		
		for itemStack in stack.arrangedSubviews {
			guard
				let radio = itemStack.subviews.compactMap({ $0 as? NSButton }).first,
				let value = context.coordinator.values[ObjectIdentifier(radio)]
				else {
				continue
			}
			
			radio.state = value == selection ? .on : .off
		}
	}
	
	private func addSpacer(to stack: NSStackView) -> NSView {
		let spacer = NSView()
		spacer.translatesAutoresizingMaskIntoConstraints = false
		spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
		spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		stack.addArrangedSubview(spacer)
		return spacer
	}

	@MainActor
	public class Coordinator: NSObject {
		var parent: IconRadioGroup
		var values: [ObjectIdentifier: Value] = [:]
		
		init(_ parent: IconRadioGroup) {
			self.parent = parent
		}
		
		@objc func selectionChanged(_ sender: NSButton) {
			selectValue(for: sender)
		}
		
		@objc func itemClicked(_ recognizer: NSClickGestureRecognizer) {
			guard let view = recognizer.view else {
				return
			}
			selectValue(for: view)
		}
		
		private func selectValue(for view: NSView) {
			guard let value = values[ObjectIdentifier(view)] else {
				return
			}
			parent.selection = value
		}
	}
}

#endif
