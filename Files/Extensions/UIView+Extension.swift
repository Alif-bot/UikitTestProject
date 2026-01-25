//
//  UIView+Extension.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
