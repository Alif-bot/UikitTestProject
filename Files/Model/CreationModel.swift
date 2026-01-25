//
//  CreationModel.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import Foundation

struct CreationModel {
    let id: UUID = UUID()
    let date: String
    let status: String
    let imageURL: String
}

extension CreationModel {
    
    static let mock: [CreationModel] = [
        .init(
            date: "Jan 24, 12:01 AM",
            status: "Completed",
            imageURL: "https://picsum.photos/400/300?1"
        ),
        .init(
            date: "Jan 23, 11:58 PM",
            status: "Completed",
            imageURL: "https://picsum.photos/400/300?2"
        ),
        .init(
            date: "Jan 23, 11:53 PM",
            status: "Completed",
            imageURL: "https://picsum.photos/400/300?3"
        ),
        .init(
            date: "Jan 23, 11:51 PM",
            status: "Completed",
            imageURL: "https://picsum.photos/400/300?4"
        ),
        .init(
            date: "Jan 23, 11:51 PM",
            status: "Completed",
            imageURL: "https://picsum.photos/400/300?5"
        ),
        .init(
            date: "Jan 23, 11:51 PM",
            status: "Completed",
            imageURL: "https://picsum.photos/400/300?6"
        ),
        .init(
            date: "Jan 23, 11:51 PM",
            status: "Completed",
            imageURL: "https://picsum.photos/400/300?7"
        ),
        .init(
            date: "Jan 23, 11:51 PM",
            status: "Completed",
            imageURL: "https://picsum.photos/400/300?8"
        ),
        .init(
            date: "Jan 23, 11:51 PM",
            status: "Completed",
            imageURL: "https://picsum.photos/400/300?9a"
        )
    ]
}
