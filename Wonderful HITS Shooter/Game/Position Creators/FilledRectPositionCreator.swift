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
