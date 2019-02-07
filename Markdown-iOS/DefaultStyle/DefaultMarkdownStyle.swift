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
        case let headingSyntax as HeadingSyntax:
            switch headingSyntax.count {
            case 1:
                return [.font: UIFont.boldSystemFont(ofSize: 40)]
            case 2:
                return [.font: UIFont.boldSystemFont(ofSize: 32)]
            case 3:
                return [.font: UIFont.boldSystemFont(ofSize: 26)]
            case 4:
                return [.font: UIFont.boldSystemFont(ofSize: 20)]
            case 5:
                return [.font: UIFont.boldSystemFont(ofSize: 16)]
            case 6:
                return [.font: UIFont.boldSystemFont(ofSize: 12)]
            default:
                fatalError("Invalid count of HeadingSyntax: \(headingSyntax.count)")
            }
        default: // looks like we just need attributes of BlockSyntax?
            fatalError("unknown syntax \(syntax)")
        }
    }
}
