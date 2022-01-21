import UIKit

protocol PlayerSpaceshipViewModelDelegate: AnyObject {
    func playerSpaceshipView(spaceshipViewModel: PlayerSpaceshipViewModel,
                             didChangeFrameWith frame: CGRect)
}

final class PlayerSpaceshipViewModel {
    
    weak var delegate: PlayerSpaceshipViewModelDelegate?
    var frame: CGRect
    
    private let player: Player
    
    init(player: Player, frame: CGRect) {
        self.player = player
        self.frame = frame
    }
    
    func sendCurrentFrame(_ frame: CGRect) {
        delegate?.playerSpaceshipView(spaceshipViewModel: self,
                                      didChangeFrameWith: frame)
    }
    
    func changePlayerFrame(with frame: CGRect) {
        player.spaceshipFrame = frame
    }
}
