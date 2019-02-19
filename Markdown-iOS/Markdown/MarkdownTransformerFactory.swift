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
        return BaseInlineTransformer(syntax: inlineSyntax, style: style)
    }
}
