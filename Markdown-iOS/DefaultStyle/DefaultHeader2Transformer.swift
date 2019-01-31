import Foundation

class DefaultHeader2Transformer: BaseBlockMarkdownTransformer {
    override func attributedString(of string: String) -> NSAttributedString {
        let startIndex = string.index(string.startIndex, offsetBy: 2)
        let endIndex = string.endIndex
        let content = String(string[startIndex..<endIndex]).trimmingCharacters(in: .whitespaces)
        let h2 = NSMutableAttributedString(string: content, attributes: style.attributes(of: syntax))
        let divider = NSAttributedString(string: "\n\u{00a0}\n", attributes: style.attributesOfHeader2Divider)
        h2.append(divider)
        return h2
    }
}
