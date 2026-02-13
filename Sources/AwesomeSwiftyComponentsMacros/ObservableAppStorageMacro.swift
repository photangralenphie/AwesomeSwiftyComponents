import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ObservableAppStorageMacro: DeclarationMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let info = parseMacroArguments(from: node, in: context) else {
            return []
        }

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
}

private func parseMacroArguments(
    from node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
) -> MacroArguments? {
    let arguments = node.arguments
    if arguments.count == 4 {
        return parseFullArguments(arguments, in: context, node: node)
    }

    if arguments.count == 3 {
        return parseShorthandArguments(arguments, in: context, node: node)
    }

    context.diagnose(
        Diagnostic(
            node: Syntax(node),
            message: SimpleDiagnosticMessage(
                message: "ObservableAppStorage requires either (key:, variableName:, type:, defaultValue:) or (_ key:, type:, defaultValue:).",
                severity: .error
            )
        )
    )
    return nil
}

private func parseFullArguments(
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
        context.diagnose(
            Diagnostic(
                node: Syntax(node),
                message: SimpleDiagnosticMessage(
                    message: "Arguments must be labeled exactly: key:, variableName:, type:, defaultValue:.",
                    severity: .error
                )
            )
        )
        return nil
    }

    guard let key = stringLiteralValue(from: first.expression) else {
        context.diagnose(
            Diagnostic(
                node: Syntax(first.expression),
                message: SimpleDiagnosticMessage(
                    message: "key must be a string literal.",
                    severity: .error
                )
            )
        )
        return nil
    }

    guard let variableName = stringLiteralValue(from: second.expression), isValidVariableName(variableName) else {
        context.diagnose(
            Diagnostic(
                node: Syntax(second.expression),
                message: SimpleDiagnosticMessage(
                    message: "variableName must be a valid Swift identifier string.",
                    severity: .error
                )
            )
        )
        return nil
    }

    guard let typeSource = typeSource(from: third.expression) else {
        context.diagnose(
            Diagnostic(
                node: Syntax(third.expression),
                message: SimpleDiagnosticMessage(
                    message: "type must be a type expression (for example: String.self).",
                    severity: .error
                )
            )
        )
        return nil
    }

    let defaultValueExpression = fourth.expression

    return MacroArguments(
        propertyName: variableName,
        typeSource: typeSource,
        defaultValueSource: trimmedSource(defaultValueExpression.description),
        keyLiteral: StringLiteralExprSyntax(content: key).description
    )
}

private func parseShorthandArguments(
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
        context.diagnose(
            Diagnostic(
                node: Syntax(node),
                message: SimpleDiagnosticMessage(
                    message: "Shorthand form must be: ObservableAppStorage(\"key\", type:, defaultValue:).",
                    severity: .error
                )
            )
        )
        return nil
    }

    guard let key = stringLiteralValue(from: first.expression) else {
        context.diagnose(
            Diagnostic(
                node: Syntax(first.expression),
                message: SimpleDiagnosticMessage(
                    message: "First argument must be a string literal key.",
                    severity: .error
                )
            )
        )
        return nil
    }

    guard isValidVariableName(key) else {
        context.diagnose(
            Diagnostic(
                node: Syntax(first.expression),
                message: SimpleDiagnosticMessage(
                    message: "Key must also be a valid Swift identifier in shorthand form.",
                    severity: .error
                )
            )
        )
        return nil
    }

    guard let typeSource = typeSource(from: second.expression) else {
        context.diagnose(
            Diagnostic(
                node: Syntax(second.expression),
                message: SimpleDiagnosticMessage(
                    message: "type must be a type expression (for example: String.self).",
                    severity: .error
                )
            )
        )
        return nil
    }

    let defaultValueExpression = third.expression
    return MacroArguments(
        propertyName: key,
        typeSource: typeSource,
        defaultValueSource: trimmedSource(defaultValueExpression.description),
        keyLiteral: StringLiteralExprSyntax(content: key).description
    )
}

private func typeSource(from expression: ExprSyntax) -> String? {
    let raw = trimmedSource(expression.description)
    if raw.isEmpty {
        return nil
    }

    if raw.hasSuffix(".self") {
        return String(raw.dropLast(5))
    }

    return raw
}

private func stringLiteralValue(from expression: ExprSyntax) -> String? {
    guard let literal = expression.as(StringLiteralExprSyntax.self) else {
        return nil
    }

    return literal.segments.compactMap { $0.as(StringSegmentSyntax.self)?.content.text }.joined()
}

private func isValidVariableName(_ value: String) -> Bool {
    guard let first = value.first else { return false }
    guard first == "_" || first.isLetter else { return false }

    return value.dropFirst().allSatisfy { $0 == "_" || $0.isLetter || $0.isNumber }
}

private func trimmedSource(_ source: String) -> String {
    source.trimmingCharacters(in: .whitespacesAndNewlines)
}

private struct MacroArguments {
    let propertyName: String
    let typeSource: String
    let defaultValueSource: String
    let keyLiteral: String
}

private struct SimpleDiagnosticMessage: DiagnosticMessage {
    let message: String
    let severity: DiagnosticSeverity

    var diagnosticID: MessageID {
        MessageID(domain: "AwesomeSwiftyComponentsMacros", id: message)
    }
}
