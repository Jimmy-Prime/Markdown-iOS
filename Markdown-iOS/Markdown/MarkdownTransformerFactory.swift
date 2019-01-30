import Foundation

protocol MarkdownTransformerFactory {
    init(style: MarkdownStyle)

    var style: MarkdownStyle { get }

    func create(syntax: MarkdownSyntax) -> MarkdownTransformer
}

class BaseMarkdownTransformerFactory: MarkdownTransformerFactory {
    let style: MarkdownStyle

    required init(style: MarkdownStyle) {
        self.style = style
    }

    func create(syntax: MarkdownSyntax) -> MarkdownTransformer {
        fatalError("subclass should override create(syntax:)")
    }
}
