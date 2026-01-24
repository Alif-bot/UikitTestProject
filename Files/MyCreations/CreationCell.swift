//
//  CreationCell.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class CreationCell: UICollectionViewCell {
    
    static let identifier = "CreationCell"
    
    private let playIcon = UIImageView(image: UIImage(systemName: "play.fill"))
    private let dateLabel = UILabel()
    private let statusLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(white: 0.15, alpha: 1)
        contentView.layer.cornerRadius = 16
        
        playIcon.tintColor = .white
        playIcon.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 13)
        
        statusLabel.textColor = .systemPink
        statusLabel.font = .boldSystemFont(ofSize: 14)
        
        let stack = UIStackView(arrangedSubviews: [dateLabel, statusLabel])
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(playIcon)
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            playIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with model: CreationModel) {
        dateLabel.text = model.date
        statusLabel.text = model.status
    }
}
