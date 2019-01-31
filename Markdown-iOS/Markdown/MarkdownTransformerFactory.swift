import Foundation

protocol MarkdownTransformerFactory {
    init(style: MarkdownStyle)

    var style: MarkdownStyle { get }

    func create(blockSyntax: BlockSyntax) -> BlockTransformer
    func create(inlineSyntax: InlineSyntax) -> InlineTransformer
}

class BaseMarkdownTransformerFactory: MarkdownTransformerFactory {
    let style: MarkdownStyle

    required init(style: MarkdownStyle) {
        self.style = style
    }

    func create(blockSyntax: BlockSyntax) -> BlockTransformer {
        fatalError("subclass should override create(blockSyntax:)")
    }

    func create(inlineSyntax: InlineSyntax) -> InlineTransformer {
        fatalError("subclass should override create(inlineSyntax:)")
    }
}
