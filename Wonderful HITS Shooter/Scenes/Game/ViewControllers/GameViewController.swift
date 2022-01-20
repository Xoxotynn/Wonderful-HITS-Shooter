import UIKit
import SnapKit

final class GameViewController: BaseViewController {

    private let playerSpaceshipView = PlayerSpaceshipView()
    private let backgroundImageView = UIImageView()
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
        bindToViewModel()
        viewModel.startLevel(withScreen: view.frame.size)
        view.layer.addSublayer(layer)
    }
    
    private func bindToViewModel() {
        playerSpaceshipView.configure(with: viewModel.playerSpaceshipViewModel)
        
        viewModel.didPreparePlayer = { [weak self] frame in
            self?.setupSpaceshipImageView(withFrame: frame)
        }
        
        viewModel.didPrepareEnemy = { [weak self] enemyViewModel in
            self?.setupEnemyView(withViewModel: enemyViewModel)
        }
        
        viewModel.didGameOver = { [weak self] isSuccess in
            self?.animateSpaceshipExplosion()
            self?.playerSpaceshipView.removeFromSuperview()
//            sleep(1)
//            self?.showAlert(text: "You are dodik")
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
    
    private func animateSpaceshipExplosion() {
//        layer.emitterPosition = playerSpaceshipView.center
        emitterCell.beginTime = CACurrentMediaTime()
        layer.beginTime = CACurrentMediaTime()
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

