import UIKit

final class FilledRectPositionCreator: PositionCreator {
    
    private let rows: Int
    private let margins: CGPoint
    private let origin: CGPoint
    
    init(rows: Int, margins: CGPoint, origin: CGPoint) {
        self.origin = origin
        self.rows = rows
        self.margins = margins
    }
    
    func createPositions(enemiesCount: Int) -> [CGPoint] {
        var positions: [CGPoint] = []
        var offsets: CGPoint = origin
        while positions.count < enemiesCount {
            while offsets.x + margins.x < 1 && positions.count < enemiesCount {
                positions.append(offsets)
                offsets.x += margins.x
            }
            
            offsets.x = origin.x
            offsets.y += margins.y
        }
        
        return positions
    }
}

extension FilledRectPositionCreator {
    static let mediumCenterRect = FilledRectPositionCreator(
        rows: 3,
        margins: CGPoint(x: 0.2, y: 0.1),
        origin: CGPoint(x: 0.2, y: -0.3))
    static let fullWidthRect = FilledRectPositionCreator(
        rows: 4,
        margins: CGPoint(x: 0.15, y: 0.1),
        origin: CGPoint(x: 0.15, y: -0.4))
}
