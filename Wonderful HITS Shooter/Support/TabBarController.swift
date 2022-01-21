import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layer = tabBar.layer
        layer.shadowPath = UIBezierPath(rect: tabBar.bounds).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
}
