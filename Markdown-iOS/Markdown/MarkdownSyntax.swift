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
        return [
            HeadingSyntax(count: 1),
            HeadingSyntax(count: 2),
            HeadingSyntax(count: 3),
            HeadingSyntax(count: 4),
            HeadingSyntax(count: 5),
            HeadingSyntax(count: 6)
        ]
    }
}

class InlineSyntax: MarkdownSyntax {
    class var all: [InlineSyntax] {
        return [BoldSyntax(), ItalicSyntax()] // order matters
    }
}

// MARK: - Block Syntax

class HeadingSyntax: BlockSyntax {
    let count: Int

    init(count: Int) {
        self.count = count
    }

    override var regexPattern: String {
        return Consts.headingSyntax(count)
    }
}

// MARK: - Inline Syntax

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
