import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct AwesomeSwiftyComponentsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ObservableAppStorageMacro.self,
    ]
}
