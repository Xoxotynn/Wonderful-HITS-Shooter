import UIKit

class RecordCellView: UITableViewCell {

    // MARK: - Properties    
    private let infoLabel = UILabel()
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
        
        addSubview(infoLabel)
        setupInfoLabel()
    }
    
    private func setupInfoLabel() {
        infoLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
    }
    
    private func bindToViewModel() {
        viewModel?.didpdateData = { [weak self] in
            self?.infoLabel.attributedText = NSAttributedString(
                string: self?.viewModel?.infoString ?? "",
                attributes: StringAttributes.getStringAttributes(fontSize: 14))
        }
    }
}
