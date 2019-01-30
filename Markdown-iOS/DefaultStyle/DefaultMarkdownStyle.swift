import UIKit

struct DefaultMarkdownStyle: MarkdownStyle {
    var transformers: [MarkdownTransformer] {
        var transformers = [MarkdownTransformer]()
        let factory = DefaultTransformerFactory(style: self)
        for syntax in MarkdownSyntax.allCases {
            transformers.append(factory.create(syntax: syntax))
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
        case .header1:
            return header1
        case .header2:
            return header2
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
