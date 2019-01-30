import Foundation

protocol MarkdownTransformer {
    init(syntax: MarkdownSyntax, style: MarkdownStyle)

    var syntax: MarkdownSyntax { get }
    var style: MarkdownStyle { get }

    func isStringValid(_ string: String) -> Bool
    func attributedString(of string: String) -> NSAttributedString
}

class BaseMarkdownTransformer: MarkdownTransformer {
    let syntax: MarkdownSyntax
    let style: MarkdownStyle

    required init(syntax: MarkdownSyntax, style: MarkdownStyle) {
        self.syntax = syntax
        self.style = style
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
