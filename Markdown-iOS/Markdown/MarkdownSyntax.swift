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
        return [Heading1Syntax(), Heading2Syntax()]
    }
}

class InlineSyntax: MarkdownSyntax {
    class var all: [InlineSyntax] {
        return [BoldSyntax(), ItalicSyntax()]
    }
}

// MARK: - Block Syntax

class Heading1Syntax: BlockSyntax {
    override var regexPattern: String {
        return "^#[^#](.*)"
    }
}

class Heading2Syntax: BlockSyntax {
    override var regexPattern: String {
        return "^##[^#](.*)"
    }
}

class BoldSyntax: InlineSyntax {
    override var regexPattern: String {
        return "\\*\\*([^\\*]+)\\*\\*"
    }
}

class ItalicSyntax: InlineSyntax {
    override var regexPattern: String {
        return "\\*([^\\*]+)\\*"
    }
}
