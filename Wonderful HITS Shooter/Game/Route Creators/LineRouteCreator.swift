//
//  LineRouteCreator.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 18.01.2022.
//

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
