import SnapKit
import UIKit

class MarkdownEditorView: UIView {
    private let leadingBackgroundMask: UIView

    private let safeAreaContainer: UIView
    private let textView: UITextView
    private let renderedTextView: UITextView

    private let renderer: MarkdownRenderer

    init(renderer: MarkdownRenderer) {
        leadingBackgroundMask = UIView()
        safeAreaContainer = UIView()
        textView = UITextView()
        renderedTextView = UITextView()

        self.renderer = renderer

        super.init(frame: .zero)

        addComponents()

        configComponents()

        configConstraints()
    }

    private func addComponents() {
        addSubview(leadingBackgroundMask)
        addSubview(safeAreaContainer)
        safeAreaContainer.addSubview(textView)
        safeAreaContainer.addSubview(renderedTextView)
    }

    private func configComponents() {
        leadingBackgroundMask.backgroundColor = .black

        textView.delegate = self
        textView.backgroundColor = .black
        textView.textColor = .white

        renderedTextView.isEditable = false
    }

    private func configConstraints() {
        leadingBackgroundMask.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(textView.snp.trailing)
        }

        safeAreaContainer.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        textView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }

        renderedTextView.isEditable = false
        renderedTextView.snp.makeConstraints { (make) in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MarkdownEditorView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        renderedTextView.attributedText = renderer.render(string: textView.text)
    }
}
