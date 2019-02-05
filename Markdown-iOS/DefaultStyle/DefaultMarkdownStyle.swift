import UIKit

struct DefaultMarkdownStyle: MarkdownStyle {
    var blockTransformers: [BlockTransformer] {
        var transformers = [BlockTransformer]()
        let factory = DefaultTransformerFactory(style: self)
        for blockSyntax in BlockSyntax.all {
            transformers.append(factory.create(blockSyntax: blockSyntax))
        }
        return transformers
    }

    var inlineTransformers: [InlineTransformer] {
        var transformers = [InlineTransformer]()
        let factory = DefaultTransformerFactory(style: self)
        for inlineSyntax in InlineSyntax.all {
            transformers.append(factory.create(inlineSyntax: inlineSyntax))
        }
        return transformers
    }

    var attributesOfHeader2Divider: [NSAttributedString.Key: Any] {
        return [
            .strikethroughStyle: NSNumber(value: 2),
            .strikethroughColor: UIColor.lightGray
        ]
    }

    func attributes(of syntax: MarkdownSyntax) -> [NSAttributedString.Key: Any] {
        switch syntax {
        case is Heading1Syntax:
            return [.font: UIFont.boldSystemFont(ofSize: 40)]
        case is Heading2Syntax:
            return [.font: UIFont.boldSystemFont(ofSize: 32)]
        case is Heading3Syntax:
            return [.font: UIFont.boldSystemFont(ofSize: 26)]
        case is Heading4Syntax:
            return [.font: UIFont.boldSystemFont(ofSize: 20)]
        case is Heading5Syntax:
            return [.font: UIFont.boldSystemFont(ofSize: 16)]
        case is Heading6Syntax:
            return [.font: UIFont.boldSystemFont(ofSize: 12)]
        default: // looks like we just need attributes of BlockSyntax?
            fatalError("unknown syntax \(syntax)")
        }
    }
}
