import Foundation

class HeadingTransformer: BaseBlockTransformer {
    let headingSyntax: HeadingSyntax

    required init(syntax: MarkdownSyntax, style: MarkdownStyle) {
        guard let headingSyntax = syntax as? HeadingSyntax else {
            fatalError("HeadingTransformer init with non HeadingSyntax: \(syntax)")
        }

        self.headingSyntax = headingSyntax

        super.init(syntax: syntax, style: style)
    }

    override func attributedString(of string: String) -> NSAttributedString {
        let startIndex = string.index(string.startIndex, offsetBy: headingSyntax.count)
        let endIndex = string.endIndex
        let content = String(string[startIndex..<endIndex]).trimmingCharacters(in: .whitespaces)
        let attrContent = NSMutableAttributedString(string: content, attributes: style.attributes(of: headingSyntax))

        if headingSyntax.hasDivider {
            let underLine = NSAttributedString(string: "\n\u{00a0}\n", attributes: style.attributesOfHeadingDivider)
            attrContent.append(underLine)
        }

        return attrContent
    }
}
