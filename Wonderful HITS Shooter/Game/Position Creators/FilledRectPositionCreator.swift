import UIKit

final class FilledRectPositionCreator: PositionCreator {
    
    private let rows: Int
    private let margins: CGPoint
    
    init(rows: Int, margins: CGPoint) {
        self.rows = rows
        self.margins = margins
    }
    
    func createPositions(enemiesCount: Int) -> [CGPoint] {
        var positions: [CGPoint] = []
        var offsets: CGPoint = margins
        while positions.count < enemiesCount {
            while offsets.x < 1 && positions.count < enemiesCount {
                positions.append(offsets)
                offsets.x += margins.x
            }
            
            offsets.x = margins.x
            offsets.y += margins.y
        }
        
        return positions
    }
}
