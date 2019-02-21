import Foundation

class UnorderedListTransformer: BaseBlockTransformer {
    override func attributedString(of string: String) -> NSAttributedString {
        let listContent = string[string.index(after: string.startIndex) ..< string.endIndex].trimmingCharacters(in: .whitespaces)
        let content = "\(style.symbolOfUnorderedListSyntax) \(listContent)"
        let attrContent = NSAttributedString(string: content, attributes: style.attributes(of: blockSyntax))
        return attrContent
    }
}
