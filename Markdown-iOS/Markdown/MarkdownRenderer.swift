import Foundation

struct MarkdownRenderer {
    var style: MarkdownStyle
    private var blockTransformers: [BlockMarkdownTransformer]
    private var inlineTransformers: [InlineMarkdownTransformer]

    init(style: MarkdownStyle) {
        self.style = style
        blockTransformers = style.blockTransformers
        inlineTransformers = style.inlineTransformers
    }

    func render(wholeText: String?) -> NSAttributedString? {
        guard let wholeText = wholeText else {
            return nil
        }

        let attrWholeText = NSMutableAttributedString()

        for line in wholeText.components(separatedBy: .newlines) {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            guard !trimmedLine.isEmpty else { continue }

            attrWholeText.append(inlineTransformLine(blockTransformLine(trimmedLine)))

            attrWholeText.append(NSAttributedString(string: "\n\n"))
        }

        return attrWholeText
    }

    private func blockTransformLine(_ line: String) -> NSAttributedString {
        var attrLine: NSAttributedString?

        for transformer in blockTransformers {
            if transformer.isStringValid(line) {
                attrLine = transformer.attributedString(of: line)
                break
            }
        }

        return attrLine ?? NSAttributedString(string: line)
    }

    private func inlineTransformLine(_ attrLine: NSAttributedString) -> NSAttributedString {
        var resultLine = attrLine
        for transformer in inlineTransformers {
            resultLine = transformer.attributedString(of: resultLine)
        }
        return resultLine
    }
}
