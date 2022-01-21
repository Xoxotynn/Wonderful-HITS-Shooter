import UIKit

final class StarView: UIView {
    // MARK: - Properties
    var fillColor: UIColor? = .brown {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private let cornerRadius: CGFloat = 2
    private var rotation: CGFloat = 54
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    // MARK: - Lifecycle
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let r = rect.width / 2
        let rc = cornerRadius
        let rn = r * 0.95 - rc

        var cangle = rotation
        for i in 1...5 {
            let cc = CGPoint(x: center.x + rn * cos(cangle * .pi / 180),
                             y: center.y + rn * sin(cangle * .pi / 180))

            let p = CGPoint(x: cc.x + rc * cos((cangle - 72) * .pi / 180),
                            y: cc.y + rc * sin((cangle - 72) * .pi / 180))

            if i == 1 {
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }
            
            path.addArc(withCenter: cc,
                        radius: rc,
                        startAngle: (cangle - 72) * .pi / 180,
                        endAngle: (cangle + 72) * .pi / 180,
                        clockwise: true)

            cangle += 144
        }

        path.close()
        (fillColor ?? .brown).set()
        path.fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
