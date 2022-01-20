//
//  BaseViewController.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 12.01.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var activityIndicator: CustomActivityIndicator = {
        CustomActivityIndicator(setOn: view)
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        view.backgroundColor = .white
    }
    
    // MARK: - Public Methods
    func startLoadingAndBlockUserInteraction() {
        activityIndicator.setOrDelete(animating: true, blockUserInteraction: true)
    }
    
    func stopLoading() {
        activityIndicator.setOrDelete(animating: false, blockUserInteraction: true)
    }
    
    func startLoading() {
        activityIndicator.setOrDelete(animating: true, blockUserInteraction: false)
    }
    
    func showAlert(text: String?) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        alert.setValue(NSAttributedString(string: text ?? "", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)
        ]), forKey: Strings.alertKey)
        alert.addAction(UIAlertAction(title: Strings.ok, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showError(_ error: Error) {
        showAlert(text: error.localizedDescription)
    }
    
    // MARK: - Private Methods
    private func setup() {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: Images.back),
                                                style: .plain,
                                                target: nil,
                                                action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}

private extension Strings {
    static let ok = "Ок"
    static let alertKey = "attributedTitle"
}
