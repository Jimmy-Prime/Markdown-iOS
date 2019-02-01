import SnapKit
import UIKit

class MarkdownEditorViewController: UIViewController {
    private let editorView: MarkdownEditorView
    private let renderer: MarkdownRenderer
    private var style: MarkdownStyle

    init() {
        style = DefaultMarkdownStyle()
        renderer = MarkdownRenderer(style: style)
        editorView = MarkdownEditorView(renderer: renderer)

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(editorView)
        editorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
