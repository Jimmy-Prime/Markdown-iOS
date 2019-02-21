import UIKit

struct DefaultMarkdownStyle: MarkdownStyle {
    var blockTransformers: [BlockTransformer] {
        var transformers = [BlockTransformer]()
        let factory = TransformerFactory()
        for blockSyntax in BlockSyntax.all {
            transformers.append(factory.create(blockSyntax: blockSyntax, style: self))
        }
        return transformers
    }

    var inlineTransformers: [InlineTransformer] {
        var transformers = [InlineTransformer]()
        let factory = TransformerFactory()
        for inlineSyntax in InlineSyntax.all {
            transformers.append(factory.create(inlineSyntax: inlineSyntax, style: self))
        }
        return transformers
    }

    var attributesOfHeadingDivider: [NSAttributedString.Key: Any] {
        return [
            .strikethroughStyle: NSNumber(value: 2),
            .strikethroughColor: UIColor.lightGray
        ]
    }

    func attributes(of blockSyntax: BlockSyntax) -> [NSAttributedString.Key: Any] {
        switch blockSyntax {
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
        case is UnorderedListSyntax:
            return [.font: UIFont.default]
        default:
            fatalError("unknown BlockSyntax \(blockSyntax)")
        }
    }

    func attributes(of inlineSyntax: InlineSyntax, with referenceFont: UIFont?) -> [NSAttributedString.Key: Any] {
        switch inlineSyntax {
        case is LinkSyntax:
            return [
                .font: referenceFont ?? .default,
                .foregroundColor: UIColor.blue,
                .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
                .underlineColor: UIColor.blue
            ]
        case is BoldSyntax:
            return [.font: referenceFont?.bold() ?? .default]
        case is ItalicSyntax:
            return [.font: referenceFont?.italic() ?? .default]
        default:
            fatalError("unknown InlineSyntax \(inlineSyntax)")
        }
    }

    var symbolOfUnorderedListSyntax: String {
        return "•"
    }
}
