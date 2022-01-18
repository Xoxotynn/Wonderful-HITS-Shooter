import UIKit
import SnapKit

final class GameViewController: UIViewController {

    private let spaceshipImageView = UIImageView()
    private let backgroundImageView = UIImageView()
    private var enemyViews: [UIView] = []
    
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
        bindToViewModel()
        viewModel.startLevel()
    }
    
    private func bindToViewModel() {
        viewModel.didPreparePlayer = { [weak self] frame in
            self?.setupSpaceshipImageView(withFrame: frame)
        }
        
        viewModel.didPrepareEnemy = { [weak self] frame, route in
            self?.setupEnemyView(withFrame: frame, route: route)
        }
    }
    
    private func setup() {
        setupView()
        setupBackgroundImageView()
    }
    
    private func setupView() {
        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(didPan(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        view.addSubview(backgroundImageView)
    }
    
    private func setupSpaceshipImageView(withFrame frame: CGRect) {
        view.addSubview(spaceshipImageView)
        spaceshipImageView.frame = viewModel.calculateAbsoluteFrame(
            from: frame,
            forScreen: view.frame.size)
        spaceshipImageView.image = UIImage(named: "spaceship")
    }
    
    private func setupEnemyView(withFrame frame: CGRect, route: [CGPoint]) {
        let enemyView = UIView()
        
        enemyView.backgroundColor = .black
        enemyView.frame = viewModel.calculateAbsoluteFrame(
            from: frame,
            forScreen: view.frame.size)
        enemyViews.append(enemyView)
        view.addSubview(enemyView)
        
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: []) {
            route.forEach { point in
                UIView.addKeyframe(withRelativeStartTime: 0,
                                   relativeDuration: 1) {
                    enemyView.frame.origin = self.viewModel
                        .calculateAbsoluteCoordinates(
                            from: point,
                            forScreen: self.view.frame.size)
                }
            }
        }
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        spaceshipImageView.center = sender.location(in: view)
    }
}

