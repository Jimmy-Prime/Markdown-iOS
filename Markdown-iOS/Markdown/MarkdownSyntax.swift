import Foundation

enum MarkdownSyntax: CaseIterable {
    case header1
    case header2

    var regexPattern: String {
        switch self {
        case .header1:
            return "^#[^#](.*)"
        case .header2:
            return "^##[^#](.*)"
        }
    }
}
