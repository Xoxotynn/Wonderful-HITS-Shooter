import UIKit

final class LineRouteCreator: RouteCreator {
    
    private let length: CGFloat
    
    init(length: CGFloat) {
        self.length = length
    }
    
    func createRoute() -> [CGPoint] {
        return [CGPoint(x: 0, y: length)]
    }
}
