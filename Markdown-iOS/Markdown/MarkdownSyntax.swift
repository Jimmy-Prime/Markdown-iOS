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
            Heading1Syntax(),
            Heading2Syntax(),
            Heading3Syntax(),
            Heading4Syntax(),
            Heading5Syntax(),
            Heading6Syntax()
        ]
    }
}

class InlineSyntax: MarkdownSyntax {
    class var all: [InlineSyntax] {
        return [BoldSyntax(), ItalicSyntax()] // order matters
    }
}

// MARK: - Block Syntax

class Heading1Syntax: BlockSyntax {
    override var regexPattern: String {
        return Consts.headingSyntax(1)
    }
}

class Heading2Syntax: BlockSyntax {
    override var regexPattern: String {
        return Consts.headingSyntax(2)
    }
}

class Heading3Syntax: BlockSyntax {
    override var regexPattern: String {
        return Consts.headingSyntax(3)
    }
}

class Heading4Syntax: BlockSyntax {
    override var regexPattern: String {
        return Consts.headingSyntax(4)
    }
}

class Heading5Syntax: BlockSyntax {
    override var regexPattern: String {
        return Consts.headingSyntax(5)
    }
}

class Heading6Syntax: BlockSyntax {
    override var regexPattern: String {
        return Consts.headingSyntax(6)
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
