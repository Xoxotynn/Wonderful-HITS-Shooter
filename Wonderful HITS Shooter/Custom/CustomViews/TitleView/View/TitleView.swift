import UIKit

class TitleView: UIView {

    // MARK: - Properties
    private let moneyImageView = UIImageView()
    private let moneyLabel = UILabel()
    private let pointsImageView = UIImageView()
    private let pointsLabel = UILabel()
    private var viewModel: TitleViewModel?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 20
        layer.shadowOpacity = 0.1
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: TitleViewModel) {
        self.viewModel = viewModel
        bindToViewModel()
        self.viewModel?.setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        backgroundColor = .blue
        
        addSubview(moneyImageView)
        addSubview(moneyLabel)
        addSubview(pointsImageView)
        addSubview(pointsLabel)
        
        setupMoneyImageView()
        setupMoneyLabel()
        setupPointsImageView()
        setupPointsLabel()
    }
    
    private func setupMoneyImageView() {
        moneyImageView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(moneyImageView.snp.height)
            make.leading.equalToSuperview().inset(Dimensions.large)
            make.top.bottom.equalToSuperview()
        }
        
        moneyImageView.image = UIImage(named: Images.money)
    }
    
    private func setupMoneyLabel() {
        moneyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(moneyImageView.snp.trailing).offset(Dimensions.standart)
        }
        
        moneyLabel.font = UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.standart))
        moneyLabel.textAlignment = .center
        moneyLabel.textColor = .black
    }
    
    private func setupPointsImageView() {
        pointsImageView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(pointsImageView.snp.height)
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(pointsLabel.snp.leading).offset(-Dimensions.standart)
        }
        
        pointsImageView.image = UIImage(named: Images.points)
    }
    
    private func setupPointsLabel() {
        pointsLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(Dimensions.large)
        }
        
        pointsLabel.font = UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.standart))
        pointsLabel.textAlignment = .center
        pointsLabel.textColor = .black
    }
    
    private func bindToViewModel() {
        viewModel?.didUpdateData = { [weak self] in
            self?.moneyLabel.text = ": " + String(describing: self?.viewModel?.money ?? 0)
            self?.pointsLabel.text = ": " + String(describing: self?.viewModel?.points ?? 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Images
private extension Images {
    static let points = "points"
    static let money = "money"
}
