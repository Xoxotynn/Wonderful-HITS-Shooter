final class RecordCellViewModel {
    // MARK: - Prioperties
    var infoString: String?
    var didpdateData: (() -> Void)?
    
    private let record: RecordModel
    private let place: Int
    
    // MARK: - Init
    init(record: RecordModel, place: Int) {
        self.record = record
        self.place = place
    }
    
    // MARK: - Public Methods
    func setup() {
        infoString = "\(place). \(record.country) : \(record.points)"
        didpdateData?()
    }
}
