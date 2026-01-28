//
//  APIError.swift
//  TestProject
//
//  Created by Md Alif Hossain on 27/1/26.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case decodingFailed
}
