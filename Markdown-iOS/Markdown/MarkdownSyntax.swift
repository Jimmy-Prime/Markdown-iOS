import UIKit

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
            HeadingSyntax(count: 1, hasDivider: true),
            HeadingSyntax(count: 2, hasDivider: true),
            HeadingSyntax(count: 3),
            HeadingSyntax(count: 4),
            HeadingSyntax(count: 5),
            HeadingSyntax(count: 6)
        ]
    }
}

class InlineSyntax: MarkdownSyntax {
    class var all: [InlineSyntax] { // order matters
        return [
            BoldSyntax(),
            ItalicSyntax()
        ]
    }

    func displayFont(referenceFont: UIFont? = nil) -> UIFont {
        return .default
    }

    func displayString(from string: String, match: NSTextCheckingResult) -> String {
        return string
    }
}

// MARK: - Block Syntax

class HeadingSyntax: BlockSyntax {
    let count: Int
    let hasDivider: Bool

    init(count: Int, hasDivider: Bool = false) {
        self.count = count
        self.hasDivider = hasDivider
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

    override func displayFont(referenceFont: UIFont?) -> UIFont {
        return referenceFont?.bold() ?? .default
    }

    override func displayString(from string: String, match: NSTextCheckingResult) -> String {
        let nsRange = NSRange(location: match.range.location + 2, length: match.range.length - 4)
        return string.substring(in: nsRange)
    }
}

class ItalicSyntax: InlineSyntax {
    override var regexPattern: String {
        return "\\*([^\\*]+)\\*"
    }

    override func displayFont(referenceFont: UIFont?) -> UIFont {
        return referenceFont?.italic() ?? .default
    }

    override func displayString(from string: String, match: NSTextCheckingResult) -> String {
        let nsRange = NSRange(location: match.range.location + 1, length: match.range.length - 2)
        return string.substring(in: nsRange)
    }
}
