//
//  Router.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class Router {
    let navigation: UINavigationController
    
    init(
        navigation: UINavigationController
    ) {
        self.navigation = navigation
    }
    
    private func push(controller: UIViewController) {
        navigation.pushViewController(controller, animated: true)
    }
    
    private func pop() {
        navigation.popViewController(animated: true)
    }
    
    func pushVocalDetailsViewContoller(
        name: String,
        genre: String,
        imageURL: String,
        onUpdate: @escaping (String) -> Void
    ) {
        let viewModel = VocalDetailsViewModel(
            name: name,
            genre: genre,
            imageURL: imageURL
        )

        let controller = VocalDetailsViewController(
            viewModel: viewModel
        )

        controller.onNameUpdate = onUpdate
        push(controller: controller)
    }
}
