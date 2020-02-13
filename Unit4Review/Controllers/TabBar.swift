//
//  TabBar.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import DataPersistence

class TabBar: UITabBarController {
    
    private var dataPersistence = DataPersistence<Article>(filename: "savedArticles.plist")
    
    
    private lazy var topStoriesVC: TopStoriesVC = {
        //This is dependency initializers
        let viewController = TopStoriesVC(dataPersistence)
        viewController.tabBarItem = UITabBarItem(title: "Top Stories", image: UIImage(systemName: "eyeglasses"), tag: 0)
        
        //This is dependency injection --> when we have public properties...but this is not best practice. We want our data to stay private
        //viewController.dataPersistence = dataPersistence
        
        return viewController
    }()
    
    private lazy var readLaterVC: ReadLaterVC = {
        let viewController = ReadLaterVC(dataPersistence)
        viewController.tabBarItem = UITabBarItem(title: "Read Later", image: UIImage(systemName: "folder"), tag: 1)
        //viewController.dataPersistence = dataPersistence
        //viewController.dataPersistence.delegate = viewController
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
