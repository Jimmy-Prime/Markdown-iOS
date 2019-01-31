import UIKit

class DefaultBoldTransformer: BaseInlineMarkdownTransformer {
    override func attributedString(of attrString: NSAttributedString) -> NSAttributedString {
        guard let regex = try? NSRegularExpression(pattern: syntax.regexPattern) else {
            fatalError("Regex error: \(syntax.regexPattern)")
        }

        let string = attrString.string
        let range = NSRange(string.startIndex.encodedOffset ..< string.endIndex.encodedOffset)
        let matches = regex.matches(in: string, range: range)

        let font = attrString.attributes(at: 0, effectiveRange: nil)[.font] as? UIFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let mutalbeAttrString = NSMutableAttributedString(attributedString: attrString)
        for match in matches.reversed() {
            let nsRange = NSRange(location: match.range.location + 2, length: match.range.length - 4)
            let subString = String(string[Range(nsRange, in: string)!])
            let replacingAttrString = NSAttributedString(string: subString, attributes: [.font: UIFont.boldSystemFont(ofSize: font.pointSize)])
            mutalbeAttrString.replaceCharacters(in: match.range, with: replacingAttrString)
        }

        return mutalbeAttrString
    }
}
