import Foundation

final class FirstLevel: Level {
    
    init() {
        super.init(player: Player(), waves: [Wave()])
    }
}
