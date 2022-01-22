final class TitleViewModel {
    // MARK: - Properties
    var money: Int?
    var points: Int?
    
    var didUpdateData: (() -> Void)?
    
    private let resources: Resources
    
    // MARK: - Init
    init(recources: Resources) {
        self.resources = recources
    }
    
    // MARK: - Public Methods
    func setup() {
        money = resources.money
        points = resources.points
        
        didUpdateData?()
    }
}
