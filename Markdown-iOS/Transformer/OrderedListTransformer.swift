import Foundation

class OrderedListTransformer: BaseBlockTransformer {
    override func attributedString(of string: String) -> NSAttributedString {
        let stripDigits = string.trimmingCharacters(in: .decimalDigits)
        let stripDot = stripDigits[stripDigits.index(after: stripDigits.startIndex) ..< stripDigits.endIndex]
        let listContent = stripDot.trimmingCharacters(in: .whitespaces)
        let content = "1. \(listContent)" // TODO: use real number
        let attrContent = NSAttributedString(string: content, attributes: style.attributes(of: blockSyntax))
        return attrContent
    }
}
