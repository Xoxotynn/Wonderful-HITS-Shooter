import UIKit
import SnapKit

final class LevelStatsView: UIView {
    
    private let titleLabel = UILabel()
    private let scoreLabel = UILabel()
    private let firstStarView = StarView(frame: .zero)
    private let secondStarView = StarView(frame: .zero)
    private let thirdStarView = StarView(frame: .zero)
    private let levelsButton = UIButton()
    private let restartButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .blue
        addSubview(titleLabel)
        addSubview(scoreLabel)
        addSubview(firstStarView)
        addSubview(secondStarView)
        addSubview(thirdStarView)
        addSubview(levelsButton)
        addSubview(restartButton)
        
        setupTitleLabel()
        setupScoreLabel()
        setupStarViews()
        setupLevelsButton()
        setupRestartButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = .pressStart2p(.regular,
                                        size: CGFloat(Dimensions.large))
        titleLabel.text = "Game Over"
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(CGFloat(Dimensions.medium))
        }
    }
    
    private func setupScoreLabel() {
        scoreLabel.textColor = .white
        scoreLabel.font = .pressStart2p(.regular,
                                        size: CGFloat(Dimensions.standart))
        scoreLabel.text = "Score: 2000"
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(secondStarView.snp.bottom)
                .offset(CGFloat(Dimensions.medium))
        }
    }
    
    private func setupStarViews() {
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
    
    private func setupLevelsButton() {
        levelsButton.backgroundColor = .systemRed
        levelsButton.setImage(UIImage(named: "levelsIcon"), for: .normal)
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
        restartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
                .offset(50)
            make.bottom.equalToSuperview().inset(CGFloat(Dimensions.standart))
            make.width.equalToSuperview().multipliedBy(0.15)
            make.width.equalTo(restartButton.snp.height)
        }
    }
}
