import Foundation

extension NSRegularExpression {
    class func match(pattern: String, in string: String) -> [NSTextCheckingResult] {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            fatalError("Regex error: \(pattern)")
        }

        let range = NSRange(string.startIndex.encodedOffset ..< string.endIndex.encodedOffset)
        return regex.matches(in: string, range: range)
    }
}
