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
        return NSAttributedString(string: content, attributes: style.attributes(of: blockSyntax))
    }
}

class Heading2Transformer: HeadingTransformer {
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
