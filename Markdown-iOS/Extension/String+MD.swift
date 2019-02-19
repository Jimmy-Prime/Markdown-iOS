import Foundation

extension String {
    func substring(in nsRange: NSRange) -> String {
        guard let range = Range(nsRange, in: self) else {
            fatalError("Invalid range: \(nsRange) in \(self)")
        }

        return String(self[range])
    }
}
