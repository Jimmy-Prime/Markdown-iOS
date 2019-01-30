import Foundation

struct MarkdownRenderer {
    var style: MarkdownStyle
    private var transformers: [MarkdownTransformer]

    init(style: MarkdownStyle) {
        self.style = style
        transformers = style.transformers
    }

    func render(string: String?) -> NSAttributedString? {
        guard let string = string else {
            return nil
        }

        let attrString = NSMutableAttributedString()

        for line in string.components(separatedBy: .newlines) {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            guard !trimmedLine.isEmpty else { continue }

            var handled = false

            for transformer in transformers {
                if transformer.isStringValid(trimmedLine) {
                    attrString.append(transformer.attributedString(of: trimmedLine))
                    handled = true
                    break
                }
            }

            if !handled {
                attrString.append(NSAttributedString(string: trimmedLine))
            }

            attrString.append(NSAttributedString(string: "\n\n"))
        }

        return attrString
    }
}
