import UIKit
import SnapKit

final class GameViewController: BaseViewController {

    private let playerSpaceshipView = PlayerSpaceshipView()
    private let scoreLabel = UILabel()
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
        viewModel.startLevel(withScreen: view.frame.size)
    }
    
    private func showGameOverScene(isSuccess: Bool) {
        viewModel.showGameOverScene(isSuccess: isSuccess)
    }
    
    private func setup() {
        bindToViewModel()
        setupView()
        setupScoreLabel()
    }
    
    private func bindToViewModel() {
        viewModel.didPreparePlayer = { [weak self] playerViewModel in
            self?.setupSpaceshipImageView(withViewModel: playerViewModel)
        }
        
        viewModel.didPrepareEnemy = { [weak self] enemyViewModel in
            self?.setupEnemyView(withViewModel: enemyViewModel)
        }
        
        viewModel.didPrepareBullet = { [weak self] bulletViewModel in
            self?.setupBulletView(withViewModel: bulletViewModel)
        }
        
        viewModel.didGameOver = { [weak self] in
            self?.playerSpaceshipView.removeFromSuperview()
            self?.showGameOverScene(isSuccess: false)
        }
        
        viewModel.didLevelFinished = { [weak self] in
            self?.showGameOverScene(isSuccess: true)
        }
        
        viewModel.didUpdateScore = { [weak self] in
            self?.scoreLabel.text = self?.viewModel.score
        }
    }
    
    private func setupView() {
        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(didPan(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        view.addSubview(scoreLabel)
    }
    
    private func setupSpaceshipImageView(
        withViewModel viewModel: PlayerSpaceshipViewModel) {
            playerSpaceshipView.configure(with: viewModel)
            view.addSubview(playerSpaceshipView)
    }
    
    private func setupEnemyView(withViewModel viewModel: EnemyViewModel) {
        let enemyView = EnemyView()
        enemyView.configure(with: viewModel)
        enemyViews.append(enemyView)
        view.addSubview(enemyView)
    }
    
    private func setupBulletView(withViewModel viewModel: BulletViewModel) {
        let bulletView = BulletView()
        bulletView.configure(with: viewModel)
        view.addSubview(bulletView)
    }
    
    private func setupScoreLabel() {
        scoreLabel.textColor = .white
        scoreLabel.font = .pressStart2p(.regular,
                                        size: CGFloat(Dimensions.standart))
        scoreLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(50)
        }
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        playerSpaceshipView.center = sender.location(in: view)
    }
}

