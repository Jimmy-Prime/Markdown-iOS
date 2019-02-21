import Foundation

class HeadingTransformer: BaseBlockTransformer {
    let headingSyntax: HeadingSyntax

    init(headingSyntax: HeadingSyntax, style: MarkdownStyle) {
        self.headingSyntax = headingSyntax
        super.init(syntax: headingSyntax, style: style)
    }

    @available(*, unavailable)
    required init(syntax: MarkdownSyntax, style: MarkdownStyle) {
        fatalError("Not available")
    }

    override func attributedString(of string: String) -> NSAttributedString {
        let startIndex = string.index(string.startIndex, offsetBy: headingSyntax.count)
        let endIndex = string.endIndex
        let content = String(string[startIndex ..< endIndex]).trimmingCharacters(in: .whitespaces)
        let attrContent = NSMutableAttributedString(string: content, attributes: style.attributes(of: headingSyntax))

        if headingSyntax.hasDivider {
            let underLine = NSAttributedString(string: "\n\u{00a0}\n", attributes: style.attributesOfHeadingDivider)
            attrContent.append(underLine)
        }

        return attrContent
    }
}
