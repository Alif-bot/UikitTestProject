//
//  SampleAPI.swift
//  TestProject
//
//  Created by Md Alif Hossain on 27/1/26.
//

import Foundation

enum SampleAPI {
    static let baseURL = "https://jsonplaceholder.typicode.com"

    case getPosts
    case createPost
    case upload
    case download

    var url: URL {
        switch self {
        case .getPosts, .createPost:
            return URL(string: "\(Self.baseURL)/posts")!
        case .upload:
            return URL(string: "https://httpbin.org/post")!
        case .download:
            return URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
        }
    }

    var method: String {
        switch self {
        case .getPosts, .download:
            return "GET"
        case .createPost, .upload:
            return "POST"
        }
    }
}
