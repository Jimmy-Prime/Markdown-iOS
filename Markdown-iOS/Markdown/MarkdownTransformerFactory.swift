import Foundation

protocol MarkdownTransformerFactory {
    init(style: MarkdownStyle)

    var style: MarkdownStyle { get }

    func create(blockSyntax: BlockSyntax) -> BlockMarkdownTransformer
    func create(inlineSyntax: InlineSyntax) -> InlineMarkdownTransformer
}

class BaseMarkdownTransformerFactory: MarkdownTransformerFactory {
    let style: MarkdownStyle

    required init(style: MarkdownStyle) {
        self.style = style
    }

    func create(blockSyntax: BlockSyntax) -> BlockMarkdownTransformer {
        fatalError("subclass should override create(blockSyntax:)")
    }

    func create(inlineSyntax: InlineSyntax) -> InlineMarkdownTransformer {
        fatalError("subclass should override create(inlineSyntax:)")
    }
}
