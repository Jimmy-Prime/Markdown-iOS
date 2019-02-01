import UIKit

struct PDFPrinter {
    func print(attributedText: NSAttributedString) -> NSMutableData {
        let printFormatter = UISimpleTextPrintFormatter(attributedText: attributedText)

        let renderer = UIPrintPageRenderer()
        renderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)

        let sizeA4 = CGSize(width: 595.2, height: 841.8)

        let pageMargins = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)

        let paperRect = CGRect(origin: .zero, size: sizeA4)

        let printableRect = paperRect.inset(by: pageMargins)

        renderer.setValue(NSValue(cgRect: paperRect), forKey: "paperRect")
        renderer.setValue(NSValue(cgRect: printableRect), forKey: "printableRect")

        let pdfData = NSMutableData()

        UIGraphicsBeginPDFContextToData(pdfData, paperRect, nil)

        renderer.prepare(forDrawingPages: NSRange(location: 0, length: renderer.numberOfPages))

        let bounds = UIGraphicsGetPDFContextBounds()

        for page in 0 ..< renderer.numberOfPages {
            UIGraphicsBeginPDFPage()
            renderer.drawPage(at: page, in: bounds)
        }

        UIGraphicsEndPDFContext()

        return pdfData
    }
}
