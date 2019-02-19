import Foundation

protocol MarkdownTransformer {
    init(syntax: MarkdownSyntax, style: MarkdownStyle)

    var syntax: MarkdownSyntax { get }
    var style: MarkdownStyle { get }
}

protocol BlockTransformer: MarkdownTransformer {
    var blockSyntax: BlockSyntax { get }

    func isStringValid(_ string: String) -> Bool
    func attributedString(of string: String) -> NSAttributedString
}

protocol InlineTransformer: MarkdownTransformer {
    var inlineSyntax: InlineSyntax { get }

    func attributedString(of string: NSAttributedString) -> NSAttributedString
}

class BaseMarkdownTransformer: MarkdownTransformer {
    let syntax: MarkdownSyntax
    let style: MarkdownStyle

    required init(syntax: MarkdownSyntax, style: MarkdownStyle) {
        self.syntax = syntax
        self.style = style
    }
}

class BaseBlockTransformer: BaseMarkdownTransformer, BlockTransformer {
    let blockSyntax: BlockSyntax

    required init(syntax: MarkdownSyntax, style: MarkdownStyle) {
        guard let blockSyntax = syntax as? BlockSyntax else {
            fatalError("BaseBlockTransformer init with non BLockSyntax: \(syntax)")
        }

        self.blockSyntax = blockSyntax

        super.init(syntax: syntax, style: style)
    }

    func isStringValid(_ string: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: syntax.regexPattern) else {
            fatalError("Regex error: \(syntax.regexPattern)")
        }

        let range = NSRange(string.startIndex.encodedOffset ..< string.endIndex.encodedOffset)
        return regex.firstMatch(in: string, range: range) != nil
    }

    func attributedString(of string: String) -> NSAttributedString {
        fatalError("subclass should override attributedString(of:)")
    }
}

class BaseInlineTransformer: BaseMarkdownTransformer, InlineTransformer {
    let inlineSyntax: InlineSyntax

    required init(syntax: MarkdownSyntax, style: MarkdownStyle) {
        guard let inlineSyntax = syntax as? InlineSyntax else {
            fatalError("BaseBlockTransformer init with non BLockSyntax: \(syntax)")
        }

        self.inlineSyntax = inlineSyntax

        super.init(syntax: syntax, style: style)
    }

    func attributedString(of attrString: NSAttributedString) -> NSAttributedString {
        let string = attrString.string
        let matches = NSRegularExpression.match(pattern: syntax.regexPattern, in: string)

        let mutalbeAttrString = NSMutableAttributedString(attributedString: attrString)
        for match in matches.reversed() {
            let font = attrString.font(at: match.range.location + 1) // should use Swifty way to implement +1
            let replacingAttrString = NSAttributedString(
                string: inlineSyntax.displayString(from: string, match: match),
                attributes: [.font: inlineSyntax.displayFont(referenceFont: font)]
            )
            mutalbeAttrString.replaceCharacters(in: match.range, with: replacingAttrString)
        }

        return mutalbeAttrString
    }
}
