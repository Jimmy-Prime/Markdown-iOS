import SnapKit
import UIKit

class MarkdownEditorViewController: UIViewController, KeyboardNotificationObserver {
    private let editorView: MarkdownEditorView
    private let renderer: MarkdownRenderer
    private var style: MarkdownStyle

//    private let toolbar = UIView()
//    private var toolbarBottomConstraint: Constraint!

    private let printer: PDFPrinter

    init() {
        style = DefaultMarkdownStyle()
        renderer = MarkdownRenderer(style: style)
        editorView = MarkdownEditorView(renderer: renderer)

        printer = PDFPrinter()

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(editorView)
        editorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        registerKeyboardNotifications()

        buildPrintButton()

//        buildToolbar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func print() {
//        let pdfData = printer.print(attributedText: editorView.renderedText)
//
//        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = view
//        present(activityViewController, animated: true, completion: nil)

        editorView.setTestFile(name: "SnapKit")
    }

    private func buildPrintButton() {
        let printButton = UIButton(type: .system)
        printButton.backgroundColor = .red
        printButton.layer.cornerRadius = 8
        printButton.clipsToBounds = true
        printButton.addTarget(self, action: #selector(print), for: .touchUpInside)
        view.addSubview(printButton)
        printButton.snp.makeConstraints { (make) in
            make.trailing.bottom.equalToSuperview().inset(20)
            make.size.equalTo(60)
        }
    }

//    private func buildToolbar() {
//        toolbar.backgroundColor = .gray
//        view.addSubview(toolbar)
//        toolbar.snp.makeConstraints { (make) in
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(44)
//            toolbarBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).constraint
//        }
//    }

    // MARK: - KeyboardNotificationObserver

//    func keyboardWillShowAnimation(endFrame: CGRect) -> [UIView] {
//        let inset = UIScreen.main.bounds.size.height - endFrame.origin.y - view.safeAreaInsets.bottom
//        toolbarBottomConstraint.update(inset: inset)
//        return [view]
//    }
//
//    func keyboardWillHideAnimation() -> [UIView] {
//        toolbarBottomConstraint.update(inset: 0)
//        return [view]
//    }
}
