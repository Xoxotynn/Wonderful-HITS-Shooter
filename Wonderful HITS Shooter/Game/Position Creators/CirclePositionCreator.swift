import UIKit

final class CirclePositionCreator: PositionCreator {
    
    private let center: CGPoint
    private let radius: CGFloat
    
    init(center: CGPoint, radius: CGFloat) {
        self.center = CGPoint(x: center.x - 0.05, y: center.y)
        self.radius = radius
    }
    
    func createPositions(enemiesCount: Int) -> [CGPoint] {
        let ratio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        let circleLength = 2 * CGFloat.pi * radius
        let distanceBetweenEnemies = circleLength / CGFloat(enemiesCount)
        let angleDelta = distanceBetweenEnemies / radius
        var angle: CGFloat = 0
        var positions: [CGPoint] = []
        
        for _ in 0..<enemiesCount {
            positions.append(CGPoint(x: center.x + radius * cos(angle),
                                     y: ratio * (center.y + radius * sin(angle))))
            angle += angleDelta
        }
        
        return positions
    }
}

extension CirclePositionCreator {
    static let smallCenterCircle = CirclePositionCreator(
        center: CGPoint(x: 0.5, y: -0.3),
        radius: 0.2)
    static let largeCenterCircle = CirclePositionCreator(
        center: CGPoint(x: 0.5, y: -0.5),
        radius: 0.4)
}
