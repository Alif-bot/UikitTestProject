//
//  VocalDetailsViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class VocalDetailsViewController: UIViewController {

    private var name: String
    private let genre: String
    private let imageURL: String

    private let imageView = UIImageView()
    private let nameTextField = UITextField()
    private let genreLabel = UILabel()
    
    var onNameUpdate: ((String) -> Void)?

    init(
        name: String,
        genre: String,
        imageURL: String
    ) {
        self.name = name
        self.genre = genre
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(
        coder: NSCoder
    ) {
        fatalError("")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        configureData()
        setupSaveButton()
    }

    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(nameTextField)
        view.addSubview(genreLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50

        nameTextField.textColor = .white
        nameTextField.font = .boldSystemFont(ofSize: 24)
        nameTextField.textAlignment = .center
        nameTextField.borderStyle = .roundedRect
        nameTextField.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        nameTextField.layer.cornerRadius = 8
        nameTextField.autocapitalizationType = .words

        genreLabel.textColor = .lightGray
        genreLabel.font = .systemFont(ofSize: 18)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),

            genreLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            genreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupSaveButton() {
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.tintColor = .white
        saveButton.backgroundColor = .systemPink
        saveButton.layer.cornerRadius = 12
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc
    private func saveTapped() {
        guard let newName = nameTextField.text, !newName.isEmpty else { return }
        name = newName
        onNameUpdate?(newName)
    
        print("New name saved: \(name)")
        
        let alert = UIAlertController(title: "Saved", message: "Name updated to \(name)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func configureData() {
        nameTextField.text = name
        genreLabel.text = genre
        loadImage()

    }
    
    private func loadImage() {
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
