import UIKit
import SnapKit

final class GameViewController: UIViewController {

    private let spaceshipImageView = UIImageView()
    private let backgroundImageView = UIImageView()
    private let enemyView = UIView()
    
    private let viewModel: GameViewModel
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        setupBackgroundImageView()
        setupSpaceshipImageView()
        setupEnemyView()
    }
    
    private func setupEnemyView() {
        enemyView.backgroundColor = .black
        enemyView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        enemyView.center = CGPoint(x: 25, y: -25)
        
        let pos1 = CGPoint(x: enemyView.center.x + 50,
                           y: enemyView.center.y + 75)
        let pos2 = CGPoint(x: enemyView.center.x + 50,
                           y: enemyView.center.y + 125)
        let pos3 = CGPoint(x: enemyView.center.x + 150,
                           y: enemyView.center.y + 50)
        
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.4) {
                self.enemyView.center = pos1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4,
                               relativeDuration: 0.4) {
                self.enemyView.center = pos2
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8,
                               relativeDuration: 0.2) {
                self.enemyView.center = pos3
            }
        }
    }
    
    private func setupView() {
        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(didPan(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        view.addSubview(backgroundImageView)
        view.addSubview(spaceshipImageView)
        view.addSubview(enemyView)
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupSpaceshipImageView() {
        spaceshipImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spaceshipImageView.center = CGPoint(x: view.center.x, y: 7 * view.center.y / 4)
        spaceshipImageView.image = UIImage(named: "spaceship")
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        spaceshipImageView.center = sender.location(in: view)
    }
}

