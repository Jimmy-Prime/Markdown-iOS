import SnapKit
import UIKit

class ViewController: UIViewController {
    private let editorView = MarkdownEditorView(renderer: MarkdownRenderer(style: DefaultMarkdownStyle()))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(editorView)
        editorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
