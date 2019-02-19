import UIKit

extension UIFont {
    class var `default`: UIFont {
        return UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }

    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        if let fontDescriptor = fontDescriptor.withSymbolicTraits([fontDescriptor.symbolicTraits, traits]) {
            return UIFont(descriptor: fontDescriptor, size: pointSize)
        } else {
            return self
        }
    }

    func italic() -> UIFont {
        return withTraits(.traitItalic)
    }

    func bold() -> UIFont {
        return withTraits(.traitBold)
    }
}
