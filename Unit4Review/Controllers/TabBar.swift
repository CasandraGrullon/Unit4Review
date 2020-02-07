//
//  TabBar.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {
    
    private lazy var topStoriesVC: TopStoriesVC = {
        let viewController = TopStoriesVC()
        viewController.tabBarItem = UITabBarItem(title: "Top Stories", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return viewController
    }()
    private lazy var readLaterVC: ReadLaterVC = {
        let viewController = ReadLaterVC()
        viewController.tabBarItem = UITabBarItem(title: "Read Later", image: UIImage(systemName: "folder"), tag: 1)
        return viewController
    }()
    private lazy var settingsVC: SettingsVC = {
        let viewController = SettingsVC()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: topStoriesVC), UINavigationController(rootViewController: readLaterVC),UINavigationController(rootViewController: settingsVC)]
    }
    
    
}
