import UIKit

protocol PlayerSpaceshipViewModelDelegate: AnyObject {
    func playerSpaceshipView(spaceshipViewModel: PlayerSpaceshipViewModel,
                             didChangeFrameWith frame: CGRect)
}

final class PlayerSpaceshipViewModel {
    
    weak var delegate: PlayerSpaceshipViewModelDelegate?
    
    func sendCurrentFrame(_ frame: CGRect) {
        delegate?.playerSpaceshipView(spaceshipViewModel: self,
                                      didChangeFrameWith: frame)
    }
}
