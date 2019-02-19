import UIKit

protocol MarkdownStyle {
    var blockTransformers: [BlockTransformer] { get }
    var inlineTransformers: [InlineTransformer] { get }
    var attributesOfHeadingDivider: [NSAttributedString.Key: Any] { get }
    func attributes(of blockSyntax: BlockSyntax) -> [NSAttributedString.Key: Any]
    func attributes(of inlineSyntax: InlineSyntax, with referenceFont: UIFont?) -> [NSAttributedString.Key: Any]
}
