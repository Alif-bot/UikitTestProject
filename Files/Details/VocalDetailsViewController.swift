//
//  VocalDetailsViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class VocalDetailsViewController: UIViewController {

    private let contentView = VocalDetailsView()
    private let viewModel: VocalDetailsViewModel

    var onNameUpdate: ((String) -> Void)?
    var onComplete: (() -> Void)?

    init(
        viewModel: VocalDetailsViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    override
    func loadView() {
        view = contentView
    }

    override
    func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupActions()
        configureInitialData()
    }

    private func configureInitialData() {
        contentView.nameTextField.text = viewModel.name
        contentView.genreLabel.text = viewModel.genre
        viewModel.loadImage()
    }

    private func bindViewModel() {
        viewModel.onImageLoaded = { [weak self] image in
            self?.contentView.imageView.image = image
        }

        viewModel.onNameSaved = { [weak self] newName in
            self?.onNameUpdate?(newName)
            self?.showSavedAlert(name: newName)
        }
    }

    private func setupActions() {
        contentView.saveButton.addTarget(
            self,
            action: #selector(saveTapped),
            for: .touchUpInside
        )
    }

    @objc
    private func saveTapped() {
        viewModel.saveName(contentView.nameTextField.text ?? "")
    }

    private func showSavedAlert(name: String) {
        let alert = UIAlertController(
            title: "Saved",
            message: "Name updated to \(name)",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.onComplete?()
            }
        )
        present(alert, animated: true)
    }
}
