final class RecordCellViewModel {
    // MARK: - Prioperties
    var placeString: String?
    var countryString: String?
    var pointsString: String?
    var didUpdateData: (() -> Void)?
    
    private let record: RecordModel
    private let place: Int
    
    // MARK: - Init
    init(record: RecordModel, place: Int) {
        self.record = record
        self.place = place
    }
    
    // MARK: - Public Methods
    func setup() {
        placeString = String(describing: place)
        countryString = String(describing: record.country)
        pointsString = String(describing: record.points)
        
        didUpdateData?()
    }
}
