import Foundation

class DefaultHeading6Transformer: BaseBlockTransformer {
    override func attributedString(of string: String) -> NSAttributedString {
        let startIndex = string.index(string.startIndex, offsetBy: 6)
        let endIndex = string.endIndex
        let content = String(string[startIndex..<endIndex]).trimmingCharacters(in: .whitespaces)
        return NSAttributedString(string: content, attributes: style.attributes(of: syntax))
    }
}
