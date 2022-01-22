final class RecordsViewModel {
    // MARK: - Properties
    var numberOfRows: Int {
        cellViewModels.count
    }
    
    var didUpdateData: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    private var cellViewModels: [RecordCellViewModel] = []
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    func start() {
        getRecords()
    }
    
    func getCellViewModel(index: Int) throws -> RecordCellViewModel {
        guard index < cellViewModels.count else {
            throw CustomError.indexOutOfRange
        }
        
        return cellViewModels[index]
    }
    
    // MARK: - Private Methods
    private func getRecords() {
        dependencies.networkManager.getRecordList { [weak self] records in
            self?.setCellViewModels(with: records)
            self?.didUpdateData?()
        } onError: { [weak self] error in
            self?.didReceiveError?(error)
        }
    }
    
    private func setCellViewModels(with recordModels: [RecordModel]) {
        cellViewModels = []
        
        let sortedRecordModels = recordModels.sorted(by: { $0.points > $1.points })
        
        for (index, element) in sortedRecordModels.enumerated() {
            cellViewModels.append(RecordCellViewModel(record: element, place: index + 1))
        }
    }
}
