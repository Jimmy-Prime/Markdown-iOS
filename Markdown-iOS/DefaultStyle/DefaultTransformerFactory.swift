import Foundation

class DefaultTransformerFactory: BaseMarkdownTransformerFactory {
    override func create(blockSyntax: BlockSyntax) -> BlockMarkdownTransformer {
        switch blockSyntax {
        case is Header1Syntax:
            return DefaultHeader1Transformer(syntax: blockSyntax, style: style)
        case is Header2Syntax:
            return DefaultHeader2Transformer(syntax: blockSyntax, style: style)
        default:
            fatalError("unknown block syntax \(blockSyntax)")
        }
    }

    override func create(inlineSyntax: InlineSyntax) -> InlineMarkdownTransformer {
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
