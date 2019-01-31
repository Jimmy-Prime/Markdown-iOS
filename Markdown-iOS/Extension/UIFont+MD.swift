import UIKit

extension UIFont {
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
