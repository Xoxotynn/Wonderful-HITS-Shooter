import UIKit
import SnapKit

final class GameViewController: UIViewController {

    private let playerSpaceshipView = PlayerSpaceshipView()
    private let backgroundImageView = UIImageView()
    private var enemyViews: [EnemyView] = []
    
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
        viewModel.startLevel(withScreen: view.frame.size)
    }
    
    private func bindToViewModel() {
        playerSpaceshipView.configure(with: viewModel.playerSpaceshipViewModel)
        
        viewModel.didPreparePlayer = { [weak self] frame in
            self?.setupSpaceshipImageView(withFrame: frame)
        }
        
        viewModel.didPrepareEnemy = { [weak self] enemyViewModel in
            self?.setupEnemyView(withViewModel: enemyViewModel)
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
        view.addSubview(playerSpaceshipView)
        playerSpaceshipView.frame = viewModel
            .calculateAbsoluteFrame(from: frame)
        playerSpaceshipView.image = UIImage(named: "spaceship")
    }
    
    private func setupEnemyView(withViewModel viewModel: EnemyViewModel) {
        let enemyView = EnemyView()
        enemyView.configure(with: viewModel)
        enemyViews.append(enemyView)
        view.addSubview(enemyView)
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        playerSpaceshipView.center = sender.location(in: view)
    }
}

