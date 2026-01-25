//
//  ImageLoading.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

protocol ImageLoading {
    func loadImage(
        from url: URL,
        completion: @escaping (UIImage?) -> Void
    )
}
