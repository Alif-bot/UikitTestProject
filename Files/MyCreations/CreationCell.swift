//
//  CreationCell.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class CreationCell: UICollectionViewCell {
    
    static let identifier = "CreationCell"
    
    // MARK: - UI
    
    private let thumbnailImageView = UIImageView()
    private let playContainerView = UIView()
    private let playIcon = UIImageView(image: UIImage(systemName: "play.fill"))
    private let dateLabel = UILabel()
    private let statusLabel = UILabel()
    private let moreButton = UIButton(type: .system)
    
    // MARK: - Init
    
    override init(
        frame: CGRect
    ) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("")
    }
    
    private func setupUI() {
        let container = contentView

        container.backgroundColor = UIColor(white: 0.15, alpha: 1)
        container.layer.cornerRadius = 18
        container.clipsToBounds = true
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true

        container.addSubview(thumbnailImageView)

        // Play container
        playContainerView.translatesAutoresizingMaskIntoConstraints = false
        playContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        playContainerView.layer.cornerRadius = 26

        playIcon.translatesAutoresizingMaskIntoConstraints = false
        playIcon.tintColor = .white

        playContainerView.addSubview(playIcon)
        container.addSubview(playContainerView)

        // Ellipsis button
        moreButton.translatesAutoresizingMaskIntoConstraints = false

        let image = UIImage(systemName: "ellipsis")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .bold))
            .withRenderingMode(.alwaysTemplate)
        // Rotate to vertical
        moreButton.transform = CGAffineTransform(rotationAngle: .pi / 2)

        moreButton.setImage(image, for: .normal)
        moreButton.tintColor = .black

        // White circular background
        moreButton.backgroundColor = .white
        moreButton.layer.cornerRadius = 6

        // Soft floating shadow
        moreButton.layer.shadowColor = UIColor.black.cgColor
        moreButton.layer.shadowOpacity = 0.15
        moreButton.layer.shadowRadius = 6
        moreButton.layer.shadowOffset = CGSize(width: 0, height: 3)

        container.addSubview(moreButton)


        // Labels
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 13)

        statusLabel.textColor = .systemPink
        statusLabel.font = .boldSystemFont(ofSize: 14)

        let textStack = UIStackView(arrangedSubviews: [dateLabel, statusLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(textStack)

        // Constraints
        NSLayoutConstraint.activate([

            thumbnailImageView.topAnchor.constraint(equalTo: container.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            // Play button
            playContainerView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            playContainerView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            playContainerView.widthAnchor.constraint(equalToConstant: 52),
            playContainerView.heightAnchor.constraint(equalToConstant: 52),

            playIcon.centerXAnchor.constraint(equalTo: playContainerView.centerXAnchor),
            playIcon.centerYAnchor.constraint(equalTo: playContainerView.centerYAnchor),

            // Text
            textStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            textStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -14),

            // Ellipsis
            moreButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            moreButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            moreButton.widthAnchor.constraint(equalToConstant: 24),
            moreButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with model: CreationModel) {
        dateLabel.text = model.date
        statusLabel.text = model.status
        loadImage(from: model.imageURL)
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        thumbnailImageView.image = nil

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard
                let data = data,
                let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self?.thumbnailImageView.image = image
            }
        }.resume()
    }
}
