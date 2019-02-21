import Foundation

protocol MarkdownTransformerFactory {
    func create(blockSyntax: BlockSyntax, style: MarkdownStyle) -> BlockTransformer
    func create(inlineSyntax: InlineSyntax, style: MarkdownStyle) -> InlineTransformer
}

class TransformerFactory: MarkdownTransformerFactory {
    func create(blockSyntax: BlockSyntax, style: MarkdownStyle) -> BlockTransformer {
        switch blockSyntax {
        case let headingSyntax as HeadingSyntax:
            return HeadingTransformer(headingSyntax: headingSyntax, style: style)
        case is UnorderedListSyntax:
            return UnorderedListTransformer(syntax: blockSyntax, style: style)
        case is OrderedListSyntax:
            return OrderedListTransformer(syntax: blockSyntax, style: style)
        default:
            fatalError("unknown block syntax \(blockSyntax)")
        }
    }

    func create(inlineSyntax: InlineSyntax, style: MarkdownStyle) -> InlineTransformer {
        switch inlineSyntax {
        case is LinkSyntax:
            return LinkTransformer(syntax: inlineSyntax, style: style)
        default:
            return BaseInlineTransformer(syntax: inlineSyntax, style: style)
        }
    }
}
