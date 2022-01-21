import UIKit
import SnapKit

final class GameOverViewController: UIViewController {
    
    private let levelStatsContainer = UIView()
    private let titleLabel = UILabel()
    private let scoreLabel = UILabel()
    private let starViews = [StarView(frame: .zero),
                             StarView(frame: .zero),
                             StarView(frame: .zero),]
    private var firstStarView: StarView {
        get {
            starViews[0]
        }
    }
    private var secondStarView: StarView {
        get {
            starViews[1]
        }
    }
    private var thirdStarView: StarView {
        get {
            starViews[2]
        }
    }
    private let levelsButton = UIButton()
    private let restartButton = UIButton()
    
    private let viewModel: GameOverViewModel
    
    @objc private func backToLevelsScene() {
        self.dismiss(animated: true)
        viewModel.backToLevelsScene()
    }
    
    @objc private func restartLevel() {
        self.dismiss(animated: true)
        viewModel.restartLevel()
    }
    
    init(viewModel: GameOverViewModel) {
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
        setupLevelStatsView()
        setupTitleLabel()
        setupScoreLabel()
        setupStarViews()
        setupLevelsButton()
        setupRestartButton()
    }
    
    private func setupView() {
        view.backgroundColor = Colors.darkShadowBlack
        view.addSubview(levelStatsContainer)
    }
    
    private func setupLevelStatsView() {
        levelStatsContainer.backgroundColor = .blue
        levelStatsContainer.addSubview(titleLabel)
        levelStatsContainer.addSubview(scoreLabel)
        levelStatsContainer.addSubview(firstStarView)
        levelStatsContainer.addSubview(secondStarView)
        levelStatsContainer.addSubview(thirdStarView)
        levelStatsContainer.addSubview(levelsButton)
        levelStatsContainer.addSubview(restartButton)
        
        levelStatsContainer.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(CGFloat(Dimensions.large))
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.4)
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = .pressStart2p(.regular,
                                        size: CGFloat(18))
        titleLabel.text = viewModel.title
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(CGFloat(Dimensions.medium))
        }
    }
    
    private func setupScoreLabel() {
        scoreLabel.textColor = .white
        scoreLabel.font = .pressStart2p(.regular,
                                        size: CGFloat(Dimensions.standart))
        scoreLabel.text = viewModel.scoreText
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(secondStarView.snp.bottom)
                .offset(CGFloat(Dimensions.medium))
        }
    }
    
    private func setupStarViews() {
        colorizeStars()
        
        firstStarView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.1)
            make.trailing.equalTo(secondStarView.snp.leading).offset(-8)
            make.centerY.equalTo(secondStarView).offset(-8)
        }
        
        secondStarView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.1)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(CGFloat(Dimensions.large))
        }
        
        thirdStarView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.1)
            make.leading.equalTo(secondStarView.snp.trailing).offset(8)
            make.centerY.equalTo(secondStarView).offset(-8)
        }
    }
    
    private func colorizeStars() {
        for index in 0..<viewModel.stars {
            guard index < starViews.count else { return }
            starViews[index].fillColor = .yellow
        }
    }
    
    private func setupLevelsButton() {
        levelsButton.backgroundColor = .systemRed
        levelsButton.setImage(UIImage(named: "levelsIcon"), for: .normal)
        levelsButton.addTarget(
            self,
            action: #selector(backToLevelsScene),
            for: .touchUpInside)
        levelsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
                .offset(-50)
            make.bottom.equalToSuperview().inset(CGFloat(Dimensions.standart))
            make.width.equalToSuperview().multipliedBy(0.15)
            make.width.equalTo(levelsButton.snp.height)
        }
    }
    
    private func setupRestartButton() {
        restartButton.backgroundColor = .systemRed
        restartButton.setImage(UIImage(named: Images.back), for: .normal)
        restartButton.addTarget(
            self,
            action: #selector(restartLevel),
            for: .touchUpInside)
        restartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
                .offset(50)
            make.bottom.equalToSuperview().inset(CGFloat(Dimensions.standart))
            make.width.equalToSuperview().multipliedBy(0.15)
            make.width.equalTo(restartButton.snp.height)
        }
    }
}
