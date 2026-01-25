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

    init(
        name: String,
        genre: String,
        imageURL: String
    ) {
        self.name = name
        self.genre = genre
        self.imageURL = URL(string: imageURL)
    }

    func loadImage() {
        guard let url = imageURL else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.onImageLoaded?(image)
            }
        }.resume()
    }

    func saveName(_ newName: String) {
        guard !newName.isEmpty else { return }
        name = newName
        onNameSaved?(newName)
    }
}
