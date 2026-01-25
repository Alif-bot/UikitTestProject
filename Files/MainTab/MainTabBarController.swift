//
//  MainTabBarController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTabs()
    }

    private func setupAppearance() {
        tabBar.tintColor = .systemPink
        tabBar.barStyle = .black
    }

    private func setupTabs() {
        viewControllers = [
            makeMyCreationsTab(),
            makeVocalTab()
        ]
    }

    private func makeMyCreationsTab() -> UIViewController {
        let viewController = MyCreationViewController(
            viewModel: MyCreationViewModel(creations: CreationModel.mock)
        )

        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(
            title: "My Creations",
            image: UIImage(systemName: "film"),
            tag: 0
        )
        return navigation
    }

    private func makeVocalTab() -> UIViewController {
        let navigation = UINavigationController()
        let router = Router(navigation: navigation)

        let viewController = VocalViewController(router: router)
        navigation.viewControllers = [viewController]

        navigation.tabBarItem = UITabBarItem(
            title: "Vocal",
            image: UIImage(systemName: "music.note"),
            tag: 1
        )
        return navigation
    }
}
