import Foundation

struct Consts {
    static func headingSyntax(_ count: Int) -> String {
        let poundString = String(repeating: "#", count: count)
        return "^\(poundString)[^#](.*)"
    }
}
