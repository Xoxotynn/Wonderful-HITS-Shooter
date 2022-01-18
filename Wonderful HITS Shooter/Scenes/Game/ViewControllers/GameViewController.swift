//
//  ViewController.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 19.12.2021.
//

import UIKit
import SnapKit

final class GameViewController: UIViewController {

    let spaceshipImageView = UIImageView()
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        setupBackgroundImageView()
        setupSpaceshipImageView()
    }
    
    private func setupView() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(didPan(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        view.addSubview(backgroundImageView)
        view.addSubview(spaceshipImageView)
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupSpaceshipImageView() {
        spaceshipImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spaceshipImageView.center = CGPoint(x: view.center.x, y: 7 * view.center.y / 4)
        spaceshipImageView.image = UIImage(named: "spaceship")
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        spaceshipImageView.center = sender.location(in: view)
    }
}

