import UIKit

final class DiagonalRouteCreator: RouteCreator {
    
    private let delta: CGPoint
    private let segmentCount: Int
    
    init(delta: CGPoint,
         segmentCount: Int) {
        self.delta = delta
        self.segmentCount = segmentCount
    }
    
    func createRoute() -> [CGPoint] {
        var route: [CGPoint] = []
        var nextX = delta.x
        for _ in 0..<segmentCount {
            route.append(CGPoint(x: nextX, y: delta.y))
            nextX = -nextX
        }
        return route
    }
}

extension DiagonalRouteCreator {
    static let largeAmplitudeRoute = DiagonalRouteCreator(
        delta: CGPoint(x: 0.7, y: 0.1),
        segmentCount: 6)
    static let smallAmplitudeRoute = DiagonalRouteCreator(
        delta: CGPoint(x: 0.3, y: 0.3),
        segmentCount: 2)
}
