//
//  VocalCell.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class VocalCell: UITableViewCell {

    static let identifier = "VocalCell"
    
    var onUseTapped: (() -> Void)?

    private let avatar = UIImageView()
    private let nameLabel = UILabel()
    private let genreLabel = UILabel()
    private let useButton = UIButton(type: .system)
    private let playButton = UIButton(type: .system)

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        // MARK: Avatar
        avatar.layer.cornerRadius = 22
        avatar.clipsToBounds = true
        avatar.widthAnchor.constraint(equalToConstant: 44).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        avatar.contentMode = .scaleAspectFill  // Make image fit nicely

        // MARK: Labels
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 16)

        genreLabel.textColor = .gray
        genreLabel.font = .systemFont(ofSize: 13)

        // MARK: USE Button
        var config = UIButton.Configuration.filled()                 // modern filled button style
        config.title = "USE"                                        // button text
        config.baseForegroundColor = .white                          // text color
        config.baseBackgroundColor = UIColor.systemPurple.withAlphaComponent(0.6) // background color
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)

        useButton.configuration = config

        // Keep width minimal, prevent stretching
        useButton.setContentHuggingPriority(.required, for: .horizontal)
        useButton.setContentCompressionResistancePriority(.required, for: .horizontal)

        // Keep width minimal, slightly bigger than content
        useButton.setContentHuggingPriority(.required, for: .horizontal)
        useButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        useButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        useButton.addTarget(self, action: #selector(useTapped), for: .touchUpInside)
        
        // MARK: Play Button
        var playConfig = UIButton.Configuration.filled()
        playConfig.baseBackgroundColor = UIColor.systemPurple.withAlphaComponent(0.4)  // background
        playConfig.baseForegroundColor = .white                                         // tint for image
        playConfig.cornerStyle = .capsule                                               // rounded button

        // Set the icon slightly smaller and centered
        playConfig.image = UIImage(systemName: "play.fill")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 10, weight: .medium)                // smaller size
        )
        playConfig.imagePlacement = .leading  // center by default if no title
        playConfig.imagePadding = 0           // no extra padding

        playButton.configuration = playConfig

        // Fixed size
        playButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 36).isActive = true


        // MARK: Stacks
        let textStack = UIStackView(arrangedSubviews: [nameLabel, genreLabel])
        textStack.axis = .vertical
        textStack.spacing = 4

        let rightStack = UIStackView(arrangedSubviews: [useButton, playButton])
        rightStack.spacing = 12
        rightStack.alignment = .center
        rightStack.distribution = .fill  //keep USE button size

        let mainStack = UIStackView(arrangedSubviews: [avatar, textStack, rightStack])
        mainStack.spacing = 12
        mainStack.alignment = .center

        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with model: VocalModel) {
        nameLabel.text = model.name
        genreLabel.text = model.genre
        loadImage(model: model)
    }
    
    private func loadImage(model: VocalModel) {
        if let url = URL(string: model.imageURL) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.avatar.image = UIImage(data: data)
                }
            }.resume()
        } else {
            avatar.image = nil
        }
    }
    
    @objc
    private func useTapped() {
        onUseTapped?()
    }
}
