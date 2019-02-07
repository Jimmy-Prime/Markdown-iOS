import Foundation

protocol MarkdownTransformerFactory {
    func create(blockSyntax: BlockSyntax, style: MarkdownStyle) -> BlockTransformer
    func create(inlineSyntax: InlineSyntax, style: MarkdownStyle) -> InlineTransformer
}

class TransformerFactory: MarkdownTransformerFactory {
    func create(blockSyntax: BlockSyntax, style: MarkdownStyle) -> BlockTransformer {
        switch blockSyntax {
        case is HeadingSyntax:
            return HeadingTransformer(syntax: blockSyntax, style: style)
        default:
            fatalError("unknown block syntax \(blockSyntax)")
        }
    }

    func create(inlineSyntax: InlineSyntax, style: MarkdownStyle) -> InlineTransformer {
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
