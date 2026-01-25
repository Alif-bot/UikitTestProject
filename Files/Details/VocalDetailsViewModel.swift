//
//  VocalDetailsViewModel.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import Foundation
import UIKit

final class VocalDetailsViewModel {

    // MARK: - State
    private(set) var name: String
    
    let genre: String
    let imageURL: URL?

    // MARK: - Closure
    var onImageLoaded: ((UIImage) -> Void)?
    var onNameSaved: ((String) -> Void)?
    
    // MARK: - Dependencies
    private let imageLoader: ImageLoading

    init(
        name: String,
        genre: String,
        imageURL: String,
        imageLoader: ImageLoading = ImageLoader()
    ) {
        self.name = name
        self.genre = genre
        self.imageURL = URL(string: imageURL)
        self.imageLoader = imageLoader
    }

    func loadImage() {
        guard let url = imageURL else { return }
        
        imageLoader.loadImage(from: url) { [weak self] image in
            guard let image else { return }
            self?.onImageLoaded?(image)
        }
    }

    func saveName(_ newName: String) {
        guard !newName.isEmpty else { return }
        name = newName
        onNameSaved?(newName)
    }
}
