import UIKit

class RecordsViewController: BaseViewController {

    // MARK: - Properties
    private let titleLabel = UILabel()
    private let recordsTableView = UITableView()
    private let viewModel: RecordsViewModel
    
    // MARK: - Init
    init(viewModel: RecordsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(titleLabel)
        view.addSubview(recordsTableView)
        
        setupTitleLabel()
        setupRecordsTableView()
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.medium)
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.attributedText = NSAttributedString(
            string: Strings.worldRecords,
            attributes: StringAttributes.getStringAttributes(fontSize: Dimensions.large))
    }
    
    private func setupRecordsTableView() {
        recordsTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimensions.medium)
        }
        
        recordsTableView.backgroundColor = .clear
        recordsTableView.separatorColor = .white
        recordsTableView.register(RecordCellView.self, forCellReuseIdentifier: Strings.reuseIdentifier)
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
    }
    
    private func bindToViewModel() {
        viewModel.didUpdateData = { [weak self] in
            DispatchQueue.main.async {
                self?.recordsTableView.reloadData()
            }
        }
        
        viewModel.didReceiveError = { [weak self] error in
            self?.showError(error)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension RecordsViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.reuseIdentifier) as? RecordCellView else {
            return UITableViewCell()
        }
        
        do {
            try cell.configure(with: viewModel.getCellViewModel(index: indexPath.row))
        } catch {
            showError(error)
        }
        
        return cell
    }
}

// MARK: - Strings
private extension Strings {
    static let worldRecords = "Мировые рекорды"
    static let reuseIdentifier = "RecordCellView"
}
