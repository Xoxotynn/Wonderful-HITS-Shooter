import UIKit

protocol PositionCreator {
    func createPositions(enemiesCount: Int) -> [CGPoint]
}
