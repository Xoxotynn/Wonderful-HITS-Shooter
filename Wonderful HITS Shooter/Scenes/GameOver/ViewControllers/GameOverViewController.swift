import UIKit
import SnapKit

final class GameOverViewController: UIViewController {
    
    private let levelStatsView = LevelStatsView()
    
    init() {
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
        view.addSubview(levelStatsView)
        
        setupView()
        setupLevelStatsView()
    }
    
    private func setupView() {
        view.backgroundColor = Colors.darkShadowBlack
    }
    
    private func setupLevelStatsView() {
        levelStatsView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(CGFloat(Dimensions.large))
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.4)
        }
    }
}
