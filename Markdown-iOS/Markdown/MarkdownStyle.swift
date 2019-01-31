import Foundation

protocol MarkdownStyle {
    var blockTransformers: [BlockTransformer] { get }
    var inlineTransformers: [InlineTransformer] { get }
    var attributesOfHeader2Divider: [NSAttributedString.Key: Any] { get }
    func attributes(of syntax: MarkdownSyntax) -> [NSAttributedString.Key: Any]
}
