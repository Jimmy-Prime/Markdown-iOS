import UIKit

protocol Component {
    func build() -> NSAttributedString
}

struct Heading: Component {
    let level: Int
    let text: String

    private var fontSize: CGFloat {
        switch level {
        case 1:
            return 40
        case 2:
            return 32
        case 3:
            return 26
        case 4:
            return 20
        case 5:
            return 16
        case 6:
            return 12
        default:
            return 0
        }
    }

    func build() -> NSAttributedString {
        return NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }
}

struct PlainText: Component {
    let text: String

    func build() -> NSAttributedString {
        return NSAttributedString(string: text)
    }
}

class MarkdownRenderer {
    private enum State {
        case beginOfParagraph

        case heading(level: Int)
        case headingPrecedingSpace(level: Int)
        case headingText(level: Int, text: String)

        case plainText(text: String)
    }

    var style: MarkdownStyle

    init(style: MarkdownStyle) {
        self.style = style
    }

    func render(wholeText: String?) -> NSAttributedString? {
        guard let wholeText = wholeText, !wholeText.isEmpty else {
            return nil
        }

        let attributedString = NSMutableAttributedString()

        for component in buildComponents(from: wholeText) {
            attributedString.append(component.build())
            attributedString.append(NSAttributedString(string: "\n"))
        }

        return attributedString
    }

    private func buildComponents(from text: String) -> [Component] {
        var components = [Component]()

        var state = State.beginOfParagraph
        for char in text {
            switch state {
            case .beginOfParagraph:
                if char == "#" {
                    state = .heading(level: 1)
                } else if char.isNewline {
                    state = .beginOfParagraph
                } else {
                    state = .plainText(text: String(char))
                }

            case .heading(let level):
                if char == "#" {
                    if level == 6 {
                        state = .plainText(text: "#######")
                    } else {
                        state = .heading(level: level + 1)
                    }
                } else if char.isWhitespace {
                    state = .headingPrecedingSpace(level: level)
                } else if char.isNewline {
                    state = .beginOfParagraph
                } else {
                    state = .headingText(level: level, text: String(char))
                }
            case .headingPrecedingSpace(let level):
                if char == "#" {
                    state = .headingText(level: level, text: "#")
                } else if char.isWhitespace {
                    state = .headingPrecedingSpace(level: level)
                } else if char.isNewline {
                    state = .beginOfParagraph
                } else {
                    state = .headingText(level: level, text: String(char))
                }
            case .headingText(let level, let text):
                if char.isNewline {
                    state = .beginOfParagraph
                    components.append(Heading(level: level, text: text))
                } else {
                    state = .headingText(level: level, text: text + String(char))
                }

            case .plainText(let text):
                if char.isNewline {
                    state = .beginOfParagraph
                    components.append(PlainText(text: text))
                } else {
                    state = .plainText(text: text + String(char))
                }
            }
        }

        switch state {
        case .headingText(let level, let text):
            components.append(Heading(level: level, text: text))
        case .plainText(let text):
            components.append(PlainText(text: text))
        default:
            break
        }

        return components
    }
}
