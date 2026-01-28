//
//  VocalUseSheetViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 28/1/26.
//

//import UIKit
//
//final class VocalUseSheetViewController: UIViewController {
//    
//    private let singerName: String
//    private let genre: String
//    
//    init(
//        singerName: String,
//        genre: String
//    ) {
//        self.singerName = singerName
//        self.genre = genre
//        super.init(
//            nibName: nil,
//            bundle: nil
//        )
//        
//        // Half sheet style
//        if let sheet = self.sheetPresentationController {
//            sheet.detents = [.medium()] // half-sheet
//            sheet.prefersGrabberVisible = true
//            sheet.preferredCornerRadius = 16
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        
//        let nameLabel = UILabel()
//        nameLabel.text = singerName
//        nameLabel.font = .boldSystemFont(ofSize: 22)
//        nameLabel.textAlignment = .center
//        
//        let genreLabel = UILabel()
//        genreLabel.text = genre
//        genreLabel.font = .systemFont(ofSize: 18)
//        genreLabel.textColor = .gray
//        genreLabel.textAlignment = .center
//        
//        let stack = UIStackView(arrangedSubviews: [nameLabel, genreLabel])
//        stack.axis = .vertical
//        stack.spacing = 8
//        stack.alignment = .center
//        
//        view.addSubview(stack)
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//}
