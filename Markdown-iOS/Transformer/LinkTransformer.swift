import Foundation

class LinkTransformer: BaseInlineTransformer {
    override func attributedString(of attrString: NSAttributedString) -> NSAttributedString {
        let string = attrString.string
        let matches = NSRegularExpression.match(pattern: syntax.regexPattern, in: string)

        let mutalbeAttrString = NSMutableAttributedString(attributedString: attrString)
        for match in matches.reversed() {
            let font = attrString.font(at: match.range.location + 1) // should use Swifty way to implement +1
            var attributes = style.attributes(of: inlineSyntax, with: font)
            print(linkString(in: string, with: match))
            attributes[NSAttributedString.Key.link] = linkString(in: string, with: match)

            let replacingAttrString = NSAttributedString(
                string: inlineSyntax.displayString(from: string, match: match),
                attributes: attributes
            )
            mutalbeAttrString.replaceCharacters(in: match.range, with: replacingAttrString)
        }

        return mutalbeAttrString
    }

    private func linkString(in string: String, with match: NSTextCheckingResult) -> String {
        let matchedString = string.substring(in: match.range)
        let rightBracketIndex = matchedString.firstIndex(of: "]")!
        let leftParenthesIndex = matchedString.index(rightBracketIndex, offsetBy: 2)
        return String(matchedString[leftParenthesIndex ..< matchedString.index(before: matchedString.endIndex)])
    }
}
