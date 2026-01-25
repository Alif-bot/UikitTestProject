//
//  MyCreationViewModel.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class MyCreationViewModel {

    private let imageLoader: ImageLoading
    private(set) var items: [CreationCellViewModel] = []

    init(
        creations: [CreationModel],
        imageLoader: ImageLoading = ImageLoader()
    ) {
        self.imageLoader = imageLoader
        self.items = creations.map(CreationCellViewModel.init)
    }

    func numberOfItems() -> Int {
        items.count
    }

    func item(at index: Int) -> CreationCellViewModel {
        items[index]
    }

    func loadImage(
        at index: Int,
        completion: @escaping (UIImage?) -> Void
    ) {
        guard let url = items[index].imageURL else { return }
        imageLoader.loadImage(from: url, completion: completion)
    }
}
