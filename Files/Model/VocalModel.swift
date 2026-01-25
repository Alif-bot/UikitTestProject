//
//  VocalModel.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import Foundation

struct VocalModel {
    var name: String
    let genre: String
    let imageURL: String
}

extension VocalModel {
    static var mock: [VocalModel] = [
        .init(
            name: "Azek",
            genre: "hiphop, husky",
            imageURL: "https://randomuser.me/api/portraits/men/10.jpg"
        ),
        .init(
            name: "Elara",
            genre: "pop, ethereal",
            imageURL: "https://randomuser.me/api/portraits/women/20.jpg"
        ),
        .init(
            name: "Talia",
            genre: "country, sweet",
            imageURL: "https://randomuser.me/api/portraits/women/30.jpg"
        ),
        .init(
            name: "Bella",
            genre: "r&b, powerful",
            imageURL: "https://randomuser.me/api/portraits/women/40.jpg"
        ),
        .init(
            name: "Gia",
            genre: "electronic, powerful",
            imageURL: "https://randomuser.me/api/portraits/women/50.jpg"
        ),
        .init(
            name: "Bruce",
            genre: "r&b, silky",
            imageURL: "https://randomuser.me/api/portraits/men/60.jpg"
        ),
        .init(
            name: "James",
            genre: "pop, captivating",
            imageURL: "https://randomuser.me/api/portraits/men/70.jpg"
        ),
        .init(
            name: "Stan",
            genre: "pop",
            imageURL: "https://randomuser.me/api/portraits/men/80.jpg"
        ),
        .init(
            name: "Rodrick",
            genre: "r&b",
            imageURL: "https://randomuser.me/api/portraits/men/90.jpg"
        )
    ]
}
