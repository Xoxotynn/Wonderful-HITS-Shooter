import UIKit

class LevelCellView: UICollectionViewCell {
    // MARK: - Properties
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let firstStarView = StarView(frame: .zero)
    private let secondStarView = StarView(frame: .zero)
    private let thirdStarView = StarView(frame: .zero)
    private var viewModel: LevelCellViewModel?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: LevelCellViewModel) {
        self.viewModel = viewModel
        bindToViewModel()
        self.viewModel?.setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        backgroundColor = .clear
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(firstStarView)
        addSubview(secondStarView)
        addSubview(thirdStarView)
        
        setupBackgroundImageView()
        setupTitleLabel()
        setupFirstStarView()
        setupSecondStarView()
        setupThirdStarView()
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(Dimensions.large)
        }
        
        backgroundImageView.image = UIImage(named: Images.level)
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(backgroundImageView)
        }
        
        titleLabel.font = UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.large))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    private func setupFirstStarView() {
        firstStarView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.2)
            make.top.equalTo(secondStarView).inset(-8)
            make.leading.equalToSuperview().inset(Dimensions.standart)
            make.trailing.equalTo(secondStarView.snp.leading).offset(-4)
        }
    }
    
    private func setupSecondStarView() {
        secondStarView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupThirdStarView() {
        thirdStarView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.2)
            make.top.equalTo(secondStarView).inset(-8)
            make.leading.equalTo(secondStarView.snp.trailing).offset(-4)
            make.trailing.equalToSuperview().inset(Dimensions.standart)
        }
    }
    
    private func bindToViewModel() {
        viewModel?.didUpdateData = { [weak self] in
            self?.titleLabel.text = String(describing: self?.viewModel?.levelNumber ?? 0)
            self?.firstStarView.fillColor = self?.viewModel?.firstStarColor
            self?.secondStarView.fillColor = self?.viewModel?.secondStarColor
            self?.thirdStarView.fillColor = self?.viewModel?.thirdStarColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
