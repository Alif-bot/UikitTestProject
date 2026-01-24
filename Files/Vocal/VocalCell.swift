//
//  VocalCell.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class VocalCell: UITableViewCell {

    static let identifier = "VocalCell"

    private let nameLabel = UILabel()
    private let genreLabel = UILabel()
    private let useButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = .clear

        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 16)

        genreLabel.textColor = .lightGray
        genreLabel.font = .systemFont(ofSize: 13)

        useButton.setTitle("USE", for: .normal)
        useButton.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.8)
        useButton.tintColor = .white
        useButton.layer.cornerRadius = 14
        useButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)

        let textStack = UIStackView(arrangedSubviews: [nameLabel, genreLabel])
        textStack.axis = .vertical

        let mainStack = UIStackView(arrangedSubviews: [textStack, useButton])
        mainStack.alignment = .center
        mainStack.spacing = 12
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with model: VocalModel) {
        nameLabel.text = model.name
        genreLabel.text = model.genre
    }
}
