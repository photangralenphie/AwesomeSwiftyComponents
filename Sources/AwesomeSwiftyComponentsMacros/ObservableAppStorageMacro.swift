import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

private struct MacroArguments {
	let propertyName: String
	let typeSource: String
	let defaultValueSource: String
	let keyLiteral: String
}

private struct SimpleDiagnosticMessage: DiagnosticMessage {
	let message: String
	let severity: DiagnosticSeverity
	
	init(_ message: String, severity: DiagnosticSeverity = .error) {
		self.message = message
		self.severity = severity
	}
	
	var diagnosticID: MessageID {
		MessageID(domain: "AwesomeSwiftyComponentsMacros", id: message)
	}
}

public struct ObservableAppStorageMacro: DeclarationMacro {
    public static func expansion(of node: some FreestandingMacroExpansionSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard let info = parseMacroArguments(from: node, in: context) else { return [] }

        return [
            """
            var \(raw: info.propertyName): \(raw: info.typeSource) {
                get {
                    access(keyPath: \\.\(raw: info.propertyName))
                    return UserDefaults.getValue(\(raw: info.keyLiteral), \(raw: info.defaultValueSource))
                }
                set {
                    withMutation(keyPath: \\.\(raw: info.propertyName)) {
                        UserDefaults.setValue(\(raw: info.keyLiteral), newValue)
                    }
                }
            }
            """,
        ]
    }
	
	private static func parseMacroArguments(from node: some FreestandingMacroExpansionSyntax, in context: some MacroExpansionContext) -> MacroArguments? {
		let arguments = node.arguments
		if arguments.count == 4 {
			return parseFullArguments(arguments, in: context, node: node)
		}
		
		if arguments.count == 3 {
			return parseShorthandArguments(arguments, in: context, node: node)
		}
		
		let message = SimpleDiagnosticMessage("ObservableAppStorage requires either (key:, variableName:, type:, defaultValue:) or (_ key:, type:, defaultValue:).")
		context.diagnose(Diagnostic(node: Syntax(node), message: message))
		
		return nil
	}
	
	private static func parseFullArguments(
		_ arguments: LabeledExprListSyntax,
		in context: some MacroExpansionContext,
		node: some FreestandingMacroExpansionSyntax
	) -> MacroArguments? {
		let first = arguments[arguments.startIndex]
		let second = arguments[arguments.index(after: arguments.startIndex)]
		let third = arguments[arguments.index(arguments.startIndex, offsetBy: 2)]
		let fourth = arguments[arguments.index(arguments.startIndex, offsetBy: 3)]
		
		guard first.label?.text == "key",
			  second.label?.text == "variableName",
			  third.label?.text == "type",
			  fourth.label?.text == "defaultValue" else {
			let message = SimpleDiagnosticMessage("Arguments must be labeled exactly: key:, variableName:, type:, defaultValue:.", severity: .error)
			context.diagnose(Diagnostic(node: Syntax(node), message: message))
			return nil
		}
		
		guard let key = stringLiteralValue(from: first.expression) else {
			let message = SimpleDiagnosticMessage("key must be a string literal.")
			context.diagnose(Diagnostic(node: Syntax(first.expression), message: message))
			return nil
		}
		
		guard let variableName = stringLiteralValue(from: second.expression), isValidVariableName(variableName) else {
			let message = SimpleDiagnosticMessage("variableName must be a valid Swift identifier string.")
			context.diagnose(Diagnostic(node: Syntax(second.expression), message: message))
			return nil
		}
		
		guard let typeSource = typeSource(from: third.expression) else {
			let message = SimpleDiagnosticMessage("type must be a type expression (for example: String.self).")
			context.diagnose(Diagnostic(node: Syntax(third.expression), message: message))
			return nil
		}
		
		let defaultValueExpression = fourth.expression
		
		return MacroArguments(
			propertyName: variableName,
			typeSource: typeSource,
			defaultValueSource: defaultValueExpression.description.trimmingCharacters(in: .whitespacesAndNewlines),
			keyLiteral: StringLiteralExprSyntax(content: key).description
		)
	}
	
	private static func parseShorthandArguments(
		_ arguments: LabeledExprListSyntax,
		in context: some MacroExpansionContext,
		node: some FreestandingMacroExpansionSyntax
	) -> MacroArguments? {
		let first = arguments[arguments.startIndex]
		let second = arguments[arguments.index(after: arguments.startIndex)]
		let third = arguments[arguments.index(arguments.startIndex, offsetBy: 2)]
		
		guard first.label == nil,
			  second.label?.text == "type",
			  third.label?.text == "defaultValue" else {
			let message = SimpleDiagnosticMessage("Shorthand form must be: ObservableAppStorage(\"key\", type:, defaultValue:).")
			context.diagnose(Diagnostic(node: Syntax(node), message: message))
			return nil
		}
		
		guard let key = stringLiteralValue(from: first.expression) else {
			let message = SimpleDiagnosticMessage("First argument must be a string literal key.")
			context.diagnose(Diagnostic(node: Syntax(first.expression), message: message))
			return nil
		}
		
		guard isValidVariableName(key) else {
			let message = SimpleDiagnosticMessage("Key must also be a valid Swift identifier in shorthand form.")
			context.diagnose(Diagnostic(node: Syntax(first.expression), message: message) )
			return nil
		}
		
		guard let typeSource = typeSource(from: second.expression) else {
			let message = SimpleDiagnosticMessage("type must be a type expression (for example: String.self).")
			context.diagnose(Diagnostic(node: Syntax(second.expression), message: message))
			return nil
		}
		
		let defaultValueExpression = third.expression
		return MacroArguments(
			propertyName: key,
			typeSource: typeSource,
			defaultValueSource: defaultValueExpression.description.trimmingCharacters(in: .whitespacesAndNewlines),
			keyLiteral: StringLiteralExprSyntax(content: key).description
		)
	}
	
	private static func typeSource(from expression: ExprSyntax) -> String? {
		let raw = expression.description.trimmingCharacters(in: .whitespacesAndNewlines)
		
		if raw.isEmpty { return nil }
		if !raw.hasSuffix(".self") { return raw }
		
		return String(raw.dropLast(5))
	}
	
	private static func stringLiteralValue(from expression: ExprSyntax) -> String? {
		guard let literal = expression.as(StringLiteralExprSyntax.self) else { return nil }
		return literal.segments.compactMap { $0.as(StringSegmentSyntax.self)?.content.text }.joined()
	}
	
	private static func isValidVariableName(_ value: String) -> Bool {
		guard let first = value.first else { return false }
		guard first == "_" || first.isLetter else { return false }
		
		return value.dropFirst().allSatisfy { $0 == "_" || $0.isLetter || $0.isNumber }
	}
}












