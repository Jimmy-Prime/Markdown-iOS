import Foundation

protocol RegularExpressionExpressible {
    var regexPattern: String { get }
}

class MarkdownSyntax: RegularExpressionExpressible {
    var regexPattern: String {
        fatalError("subclass should override regexPattern")
    }
}

class BlockSyntax: MarkdownSyntax {
    class var all: [BlockSyntax] {
        return [Header1Syntax(), Header2Syntax()]
    }
}

class InlineSyntax: MarkdownSyntax {
    class var all: [InlineSyntax] {
        return [BoldSyntax()]
    }
}

// MARK: - Block Syntax

class Header1Syntax: BlockSyntax {
    override var regexPattern: String {
        return "^#[^#](.*)"
    }
}

class Header2Syntax: BlockSyntax {
    override var regexPattern: String {
        return "^##[^#](.*)"
    }
}

class BoldSyntax: InlineSyntax {
    override var regexPattern: String {
        return "\\*\\*([^\\*]+)\\*\\*"
    }
}
