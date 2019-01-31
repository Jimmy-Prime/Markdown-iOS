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
            return header1
        case is Heading2Syntax:
            return header2
        default: // looks like we just need attributes of BlockSyntax?
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
