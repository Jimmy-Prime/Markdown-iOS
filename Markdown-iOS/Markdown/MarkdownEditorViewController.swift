import SnapKit
import UIKit

class MarkdownEditorViewController: UIViewController {
    private let editorView: MarkdownEditorView
    private let renderer: MarkdownRenderer
    private var style: MarkdownStyle

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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func print() {
        let pdfData = printer.print(attributedText: editorView.renderedText)

        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true, completion: nil)
    }
}
