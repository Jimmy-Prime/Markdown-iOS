import Foundation

protocol MarkdownStyle {
    var blockTransformers: [BlockTransformer] { get }
    var inlineTransformers: [InlineTransformer] { get }
    var attributesOfHeadingDivider: [NSAttributedString.Key: Any] { get }
    func attributes(of syntax: MarkdownSyntax) -> [NSAttributedString.Key: Any]
}
