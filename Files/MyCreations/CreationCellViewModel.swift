//
//  CreationCellViewModel.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import Foundation

final class CreationCellViewModel {

    let dateText: String
    let statusText: String
    let imageURL: URL?

    init(
        model: CreationModel
    ) {
        self.dateText = model.date
        self.statusText = model.status
        self.imageURL = URL(string: model.imageURL)
    }
}
