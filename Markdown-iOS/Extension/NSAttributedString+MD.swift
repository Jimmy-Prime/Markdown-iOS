import UIKit

extension NSAttributedString {
    func font(at location: Int) -> UIFont {
        return attributes(at: location, effectiveRange: nil)[.font] as? UIFont ?? UIFont.default
    }
}
