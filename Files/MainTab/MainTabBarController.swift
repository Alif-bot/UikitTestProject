//
//  MainTabBarController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = .systemPink
        tabBar.barStyle = .black
    }
    
    private func setupTabs() {
        let creationViewController = UINavigationController(
            rootViewController: MyCreationViewController()
        )
        
        creationViewController.tabBarItem = UITabBarItem(
            title: "My Creations",
            image: UIImage(systemName: "film"),
            tag: 0
        )
        
        let vocalViewController = UINavigationController(
            rootViewController: VocalViewController()
        )
        
        vocalViewController.tabBarItem = UITabBarItem(
            title: "Vocal",
            image: UIImage(systemName: "music.note"),
            tag: 1
        )
        
        viewControllers = [creationViewController, vocalViewController]
    }
}
