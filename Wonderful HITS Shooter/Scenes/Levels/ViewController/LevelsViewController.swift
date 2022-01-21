import UIKit

final class LevelsViewController: BaseViewController {

    // MARK: - Properties
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let flowLayout = UICollectionViewFlowLayout.init()
    private let viewModel: LevelsViewModel
    
    // MARK: - Init
    init(viewModel: LevelsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
        viewModel.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(collectionView)
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.large)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
        }
        
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.register(LevelCellView.self, forCellWithReuseIdentifier: Strings.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bindToViewModel() {
        viewModel.didReceiveError = { [weak self] error in
            self?.showError(error)
        }
        
        viewModel.didUpdateData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension LevelsViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countOfLevels
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.reuseIdentifier, for: indexPath) as? LevelCellView else {
            return UICollectionViewCell()
        }
        
        do {
            try cell.configure(with: viewModel.getCellViewModel(withIndex: indexPath.row))
        } catch {
            showError(error)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LevelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize
    }
}

// MARK: - Strings
private extension Strings {
    static let reuseIdentifier = "LevelCellView"
}
