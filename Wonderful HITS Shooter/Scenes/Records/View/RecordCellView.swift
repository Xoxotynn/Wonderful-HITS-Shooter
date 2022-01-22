import UIKit

class RecordCellView: UITableViewCell {

    // MARK: - Properties
    private let placeLabel = UILabel()
    private let countryLabel = UILabel()
    private let pointsLabel = UILabel()
    private var viewModel: RecordCellViewModel?
    
    // MARK: - Public Methods
    func configure(with viewModel: RecordCellViewModel) {
        setup()
        
        self.viewModel = viewModel
        bindToViewModel()
        self.viewModel?.setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(placeLabel)
        addSubview(countryLabel)
        addSubview(pointsLabel)
        
        setupPlaceLabel()
        setupCountryLabel()
        setupPointsLabel()
    }
    
    private func setupPlaceLabel() {
        placeLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(Dimensions.standart)
        }
        
        placeLabel.textAlignment = .left
    }
    
    private func setupCountryLabel() {
        countryLabel.snp.makeConstraints { make in
            make.leading.equalTo(placeLabel.snp.trailing).offset(Dimensions.standart)
            make.top.bottom.equalToSuperview().inset(Dimensions.standart)
        }
        
        countryLabel.textAlignment = .center
        countryLabel.numberOfLines = 0
    }
    
    private func setupPointsLabel() {
        pointsLabel.snp.makeConstraints { make in
            make.leading.equalTo(countryLabel.snp.trailing).offset(Dimensions.standart)
            make.trailing.top.bottom.equalToSuperview().inset(Dimensions.standart)
        }
        
        pointsLabel.textAlignment = .right
    }
    
    private func bindToViewModel() {
        viewModel?.didUpdateData = { [weak self] in
            self?.placeLabel.attributedText = NSAttributedString(
                string: self?.viewModel?.placeString ?? "",
                attributes: StringAttributes.getStringAttributes(fontSize: 14))
            self?.countryLabel.attributedText = NSAttributedString(
                string: self?.viewModel?.countryString ?? "",
                attributes: StringAttributes.getStringAttributes(fontSize: 14))
            self?.pointsLabel.attributedText = NSAttributedString(
                string: self?.viewModel?.pointsString ?? "",
                attributes: StringAttributes.getStringAttributes(fontSize: 14))
        }
    }
}
