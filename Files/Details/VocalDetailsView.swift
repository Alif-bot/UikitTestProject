//
//  VocalDetailsView.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class VocalDetailsView: UIView {

    let imageView = UIImageView()
    let nameTextField = UITextField()
    let genreLabel = UILabel()
    let saveButton = UIButton(type: .system)

    override init(
        frame: CGRect
    ) {
        super.init(frame: frame)
        backgroundColor = .black
        setupUI()
    }

    required init?(
        coder: NSCoder
    ) {
        fatalError("")
    }

    private func setupUI() {
        addSubViews(
            imageView,
            nameTextField,
            genreLabel,
            saveButton
        )
        
        [imageView, nameTextField, genreLabel, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50

        nameTextField.textColor = .white
        nameTextField.font = .boldSystemFont(ofSize: 24)
        nameTextField.textAlignment = .center
        nameTextField.borderStyle = .roundedRect
        nameTextField.backgroundColor = UIColor.white.withAlphaComponent(0.1)

        genreLabel.textColor = .lightGray
        genreLabel.font = .systemFont(ofSize: 18)

        saveButton.setTitle("Save", for: .normal)
        saveButton.tintColor = .white
        saveButton.backgroundColor = .systemPink
        saveButton.layer.cornerRadius = 12

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),

            genreLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            genreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            saveButton.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
