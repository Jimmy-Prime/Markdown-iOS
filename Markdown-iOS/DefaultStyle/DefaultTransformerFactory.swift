import Foundation

class DefaultTransformerFactory: BaseMarkdownTransformerFactory {
    override func create(syntax: MarkdownSyntax) -> MarkdownTransformer {
        switch syntax {
        case .header1:
            return DefaultHeader1Transformer(syntax: syntax, style: style)
        case .header2:
            return DefaultHeader2Transformer(syntax: syntax, style: style)
        }
    }
}
