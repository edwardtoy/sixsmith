
import UIKit
import Sixsmith

class HexagonView: UIView {

    var paths: [[Vector2]] = Array()

    func drawHexagon(with path: [Vector2]) {
        let bezier = UIBezierPath(points: path)
        bezier.stroke()
        bezier.fill()
    }

    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setStrokeColor(UIColor.white.cgColor)
        ctx?.setFillColor(UIColor(white: 0.5, alpha: 1).cgColor)
        ctx?.setLineWidth(1)

        paths.forEach { path in
            drawHexagon(with: path)
        }
    }
}

extension UIBezierPath {
    public convenience init(points: [Vector2], shouldBeClosed: Bool = true) {
        self.init()
        self.lineWidth = 1

        if let first = points.first {
            move(to: first.point)
        }
        points.forEach {
            addLine(to: $0.point)
        }
        if points.count > 1 && shouldBeClosed {
            close()
        }
    }
}