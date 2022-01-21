import UIKit

final class TabBarCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    private let dependencies: Dependencies
    
    private let titleView: TitleView
    private var titleViewModel: TitleViewModel? {
        didSet {
            titleView.configure(with: titleViewModel
                                ?? TitleViewModel(recources: Resources(money: 0,
                                                                       points: 0)))
        }
    }
    private var points: Int = 0 {
        didSet {
            titleViewModel = TitleViewModel(recources: Resources(money: money, points: points))
        }
    }
    private var money: Int = 0 {
        didSet {
            titleViewModel = TitleViewModel(recources: Resources(money: money, points: points))
        }
    }
    
    // MARK: - Init
    init(dependencies: Dependencies, rootNavigationController: UINavigationController) {
        self.dependencies = dependencies
        self.rootNavigationController = rootNavigationController
        self.titleView = TitleView(frame: rootNavigationController.navigationBar.bounds)
        self.rootNavigationController.navigationBar.addSubview(titleView)
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() {
        showTabs()
    }
    
    // MARK: - Private Methods
    private func showTabs() {
        let tabBarController = TabBarController()
        
        let levelsNavigationController = createLevelsNavigationController()
        let upgradingNavigationController = createUpgradingNavigationController()
        let recordsNavigationController = createRecordsNavigationController()
        
        tabBarController.setViewControllers([ levelsNavigationController,
                                              upgradingNavigationController,
                                              recordsNavigationController ], animated: true)
        
        rootNavigationController.setViewControllers([ tabBarController ], animated: true)
    }
    
    private func createLevelsNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        
        let item = UITabBarItem(title: Strings.levels,
                                image: UIImage(named: Images.levels),
                                selectedImage: nil)
        item.setTitleTextAttributes([
            .font : UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.standart/2))
        ], for: .normal)
        
        navController.tabBarItem = item
        
        let levelsCoordinator = LevelsCoordinator(dependencies: dependencies,
                                                  rootNavigationController: navController)
        levelsCoordinator.delegate = self
        childCoordinators.append(levelsCoordinator)
        levelsCoordinator.start()
        
        return navController
    }
    
    private func createUpgradingNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        
        let item = UITabBarItem(title: Strings.upgrading,
                                image: UIImage(named: Images.upgrading),
                                selectedImage: nil)
        item.imageInsets = UIEdgeInsets(top: 0, left: -5, bottom: -10, right: -5)
        item.setTitleTextAttributes([
            .font : UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.standart/2))
        ], for: .normal)
        
        navController.tabBarItem = item
        
        let upgradingCoordinator = UpgradingCoordinator(dependencies: dependencies,
                                                        rootNavigationController: navController)
        childCoordinators.append(upgradingCoordinator)
        upgradingCoordinator.start()
        
        return navController
    }
    
    private func createRecordsNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        
        let item = UITabBarItem(title: Strings.records,
                                image: UIImage(named: Images.records),
                                selectedImage: nil)
        item.setTitleTextAttributes([
            .font : UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.standart/2))
        ], for: .normal)
        
        navController.tabBarItem = item
        
        let recordsCoordinator = RecordsCoordinator(dependencies: dependencies,
                                                    rootNavigationController: navController)
        childCoordinators.append(recordsCoordinator)
        recordsCoordinator.start()
        
        return navController
    }
}

// MARK: - TabBarItemDelegate
extension TabBarCoordinator: TabBarItemDelegate {
    func configureTitleView(withPoints points: Int) {
        self.points = points
    }
    
    func configureTitleView(withMoney money: Int) {
        self.money = money
    }
}

// MARK: - Strings
private extension Strings {
    static let levels = "Уровни"
    static let upgrading = "Улучшения"
    static let records = "Рекорды"
}

// MARK: - Images
private extension Images {
    static let levels = "levelsIcon"
    static let upgrading = "upgradingIcon"
    static let records = "recordsIcon"
}
