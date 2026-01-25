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

    // MARK: - MVVM Configure
    func configure(
        with viewModel: CreationCellViewModel
    ) {
        dateLabel.text = viewModel.dateText
        statusLabel.text = viewModel.statusText
        thumbnailImageView.image = nil
    }

    func setImage(_ image: UIImage?) {
        thumbnailImageView.image = image
    }

    // MARK: - UI Setup
    private func setupUI() {
        contentView.backgroundColor = UIColor(white: 0.15, alpha: 1)
        contentView.layer.cornerRadius = 18
        contentView.clipsToBounds = true

        setupThumbnail()
        setupPlayIcon()
        setupMoreButton()
        setupLabels()
    }

    private func setupThumbnail() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        contentView.addSubview(thumbnailImageView)

        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupPlayIcon() {
        playContainerView.translatesAutoresizingMaskIntoConstraints = false
        playContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        playContainerView.layer.cornerRadius = 26
        contentView.addSubview(playContainerView)

        playIcon.translatesAutoresizingMaskIntoConstraints = false
        playIcon.tintColor = .white
        playContainerView.addSubview(playIcon)

        NSLayoutConstraint.activate([
            playContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playContainerView.widthAnchor.constraint(equalToConstant: 52),
            playContainerView.heightAnchor.constraint(equalToConstant: 52),

            playIcon.centerXAnchor.constraint(equalTo: playContainerView.centerXAnchor),
            playIcon.centerYAnchor.constraint(equalTo: playContainerView.centerYAnchor)
        ])
    }

    private func setupMoreButton() {
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.backgroundColor = .white
        moreButton.layer.cornerRadius = 6

        let image = UIImage(systemName: "ellipsis")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .bold))
            .withRenderingMode(.alwaysTemplate)
        // Rotate to vertical
        moreButton.transform = CGAffineTransform(rotationAngle: .pi / 2)

        moreButton.setImage(image, for: .normal)
        moreButton.tintColor = .black

        // Optional shadow for floating effect
        moreButton.layer.shadowColor = UIColor.black.cgColor
        moreButton.layer.shadowOpacity = 0.15
        moreButton.layer.shadowRadius = 6
        moreButton.layer.shadowOffset = CGSize(width: 0, height: 3)

        contentView.addSubview(moreButton)

        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            moreButton.widthAnchor.constraint(equalToConstant: 24),
            moreButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func setupLabels() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 13)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = .systemPink
        statusLabel.font = .boldSystemFont(ofSize: 14)

        let textStack = UIStackView(arrangedSubviews: [dateLabel, statusLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textStack)

        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            textStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
