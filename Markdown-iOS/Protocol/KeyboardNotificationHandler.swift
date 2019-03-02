import UIKit

protocol KeyboardNotificationObserver: AnyObject {
    func registerKeyboardNotifications()

    func keyboardWillShowAnimation(endFrame: CGRect) -> [UIView]
    func keyboardWillShowAnimationCompletion()
    func keyboardDidShow()

    func keyboardWillHideAnimation() -> [UIView]
    func keyboardWillHideAnimationCompletion()
    func keyboardDidHide()
}

extension KeyboardNotificationObserver {
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification) { [weak self] (notification) in
            self?.keyboardWillShow(notification)
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification) { [weak self] (notification) in
            self?.keyboardDidShow(notification)
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification) { [weak self] (notification) in
            self?.keyboardWillHide(notification)
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification) { [weak self] (notification) in
            self?.keyboardDidHide(notification)
        }
    }

    /// Default empty implementation
    func keyboardWillShowAnimation(endFrame: CGRect) -> [UIView] { return [] }
    func keyboardWillShowAnimationCompletion() {}
    func keyboardDidShow() {}

    func keyboardWillHideAnimation() -> [UIView] { return [] }
    func keyboardWillHideAnimationCompletion() {}
    func keyboardDidHide() {}

    private func keyboardWillShow(_ notification: Notification) {
        printKeyboardNotification(notification, message: "keyboard will show")

        guard let userInfo = notification.userInfo,
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let curveInt = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
            let curve = UIView.AnimationCurve(rawValue: curveInt),
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }

        UIView.setAnimationCurve(curve)
        UIView.animate(
            withDuration: duration,
            animations: { [weak self] in
                if let views = self?.keyboardWillShowAnimation(endFrame: endFrame) {
                    views.forEach {
                        $0.layoutIfNeeded()
                    }
                }
            },
            completion: { [weak self] (_) in
                self?.keyboardWillShowAnimationCompletion()
            }
        )
    }

    private func keyboardDidShow(_ notification: Notification) {
        printKeyboardNotification(notification, message: "keyboard did show")

//        guard let userInfo = notification.userInfo,
//            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//                return
//        }
//
//        keyboardFrame = endFrame

        keyboardDidShow()
    }

    private func keyboardWillHide(_ notification: Notification) {
        printKeyboardNotification(notification, message: "keyboard will hide")

        guard let userInfo = notification.userInfo,
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let curveInt = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
            let curve = UIView.AnimationCurve(rawValue: curveInt) else {
                return
        }

        UIView.setAnimationCurve(curve)
        UIView.animate(
            withDuration: duration,
            animations: { [weak self] in
                if let views = self?.keyboardWillHideAnimation() {
                    views.forEach {
                        $0.layoutIfNeeded()
                    }
                }
            },
            completion: { [weak self] (_) in
                self?.keyboardWillHideAnimationCompletion()
            }
        )
    }

    private func keyboardDidHide(_ notification: Notification) {
        printKeyboardNotification(notification, message: "keyboard did hide")

//        guard let userInfo = notification.userInfo,
//            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//                return
//        }
//
//        keyboardFrame = endFrame

        keyboardDidHide()
    }

    private func printKeyboardNotification(_ notification: Notification, message: String = "") {
        if !message.isEmpty {
            print(message)
        }

        if let userInfo = notification.userInfo {
            for (key, value) in userInfo {
                print("\(key): \(value)")
            }
        }
    }
}
