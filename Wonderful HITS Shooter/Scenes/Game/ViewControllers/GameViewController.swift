import UIKit
import SnapKit

final class GameViewController: BaseViewController {

    private let playerSpaceshipView = PlayerSpaceshipView()
    private let scoreLabel = UILabel()
    private var enemyViews: [EnemyView] = []
    
    private let viewModel: GameViewModel
    
    private lazy var emitterCell: CAEmitterCell = {
        var cell = CAEmitterCell()
        cell.contents = UIImage(named: "spaceship")?.cgImage
        cell.lifetime = 100
        cell.birthRate = 200
        cell.velocity = 200
        cell.scale = 0.1
        cell.spin = 1
        cell.alphaSpeed = -1
        cell.scaleSpeed = -0.1
        cell.duration = 0.05
        cell.emissionRange = CGFloat.pi * 2
        cell.yAcceleration = -80
        return cell
    }()
    
    private lazy var layer: CAEmitterLayer = {
        let layer = CAEmitterLayer()
        layer.emitterPosition = playerSpaceshipView.center
        layer.emitterSize = CGSize(width: 20, height: 20)
        layer.emitterShape = .circle
        layer.emitterCells = [emitterCell]
        layer.lifetime = 0.1
        return layer
    }()
    
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
        view.layer.addSublayer(layer)
    }
    
    private func showGameOverScene() {
        viewModel.showGameOverScene()
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
            self?.animateSpaceshipExplosion()
            self?.playerSpaceshipView.removeFromSuperview()
            self?.showGameOverScene()
//            sleep(1)
//            self?.showAlert(text: "You are dodik")
        }
        
        viewModel.didLevelFinished = { [weak self] in
            self?.showGameOverScene()
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
    
    private func animateSpaceshipExplosion() {
        layer.emitterPosition = playerSpaceshipView.center
        emitterCell.beginTime = CACurrentMediaTime()
        layer.beginTime = CACurrentMediaTime()
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

