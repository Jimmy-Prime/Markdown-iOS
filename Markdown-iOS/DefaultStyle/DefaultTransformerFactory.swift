import Foundation

class DefaultTransformerFactory: BaseMarkdownTransformerFactory {
    override func create(blockSyntax: BlockSyntax) -> BlockTransformer {
        switch blockSyntax {
        case is Heading1Syntax:
            return DefaultHeading1Transformer(syntax: blockSyntax, style: style)
        case is Heading2Syntax:
            return DefaultHeading2Transformer(syntax: blockSyntax, style: style)
        default:
            fatalError("unknown block syntax \(blockSyntax)")
        }
    }

    override func create(inlineSyntax: InlineSyntax) -> InlineTransformer {
        switch inlineSyntax {
        case is BoldSyntax:
            return DefaultBoldTransformer(syntax: inlineSyntax, style: style)
        case is ItalicSyntax:
            return DefaultItalicTransformer(syntax: inlineSyntax, style: style)
        default:
            fatalError("unknown inline syntax \(inlineSyntax)")
        }
    }
}
