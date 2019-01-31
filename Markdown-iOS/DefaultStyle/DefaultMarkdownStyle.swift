import UIKit

struct DefaultMarkdownStyle: MarkdownStyle {
    var blockTransformers: [BlockMarkdownTransformer] {
        var transformers = [BlockMarkdownTransformer]()
        let factory = DefaultTransformerFactory(style: self)
        for blockSyntax in BlockSyntax.all {
            transformers.append(factory.create(blockSyntax: blockSyntax))
        }
        return transformers
    }

    var inlineTransformers: [InlineMarkdownTransformer] {
        var transformers = [InlineMarkdownTransformer]()
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
        case is Header1Syntax:
            return header1
        case is Header2Syntax:
            return header2
        default:
            fatalError("unknown syntax \(syntax)")
        }
    }

    private var header1: [NSAttributedString.Key: Any] {
        return [
            .font: UIFont.boldSystemFont(ofSize: 40)
        ]
    }

    private var header2: [NSAttributedString.Key: Any] {
        return [
            .font: UIFont.boldSystemFont(ofSize: 32)
        ]
    }
}
