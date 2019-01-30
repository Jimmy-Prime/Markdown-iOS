import Foundation

protocol MarkdownStyle {
    var transformers: [MarkdownTransformer] { get }
    var attributesOfHeader2Divider: [NSAttributedString.Key: Any] { get }
    func attributes(of syntax: MarkdownSyntax) -> [NSAttributedString.Key: Any]
}
