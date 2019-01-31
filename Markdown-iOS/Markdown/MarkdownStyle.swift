import Foundation

protocol MarkdownStyle {
    var blockTransformers: [BlockMarkdownTransformer] { get }
    var inlineTransformers: [InlineMarkdownTransformer] { get }
    var attributesOfHeader2Divider: [NSAttributedString.Key: Any] { get }
    func attributes(of syntax: MarkdownSyntax) -> [NSAttributedString.Key: Any]
}
