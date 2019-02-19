import Foundation

class LinkTransformer: BaseInlineTransformer {
    override func modify(attributes: inout [NSAttributedString.Key: Any], in string: String, with match: NSTextCheckingResult) {
        let matchedString = string.substring(in: match.range)
        let rightBracketIndex = matchedString.firstIndex(of: "]")!
        let leftParenthesIndex = matchedString.index(rightBracketIndex, offsetBy: 2) // 2 is for "]("
        let linkString = String(matchedString[leftParenthesIndex ..< matchedString.index(before: matchedString.endIndex)])

        attributes[.link] = linkString
    }
}
