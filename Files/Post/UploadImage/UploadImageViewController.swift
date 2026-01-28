//
//  UploadImageViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 28/1/26.
//

import UIKit

final class UploadImageViewController: UIViewController {

    private let imageView = UIImageView()
    private let pickButton = UIButton(type: .system)
    private let uploadButton = UIButton(type: .system)

    private var selectedImageData: Data?
    
    // MARK: - Loading View
    private let loadingView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLoadingView()
    }

    // MARK: - UI
    private func setupUI() {
        title = "Upload Image"
        view.backgroundColor = .systemBackground

        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.secondarySystemBackground
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true

        pickButton.setTitle("Pick Image", for: .normal)
        uploadButton.setTitle("Upload", for: .normal)

        pickButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        uploadButton.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)

        uploadButton.isEnabled = false

        let stack = UIStackView(arrangedSubviews: [
            imageView,
            pickButton,
            uploadButton
        ])
        stack.axis = .vertical
        stack.spacing = 16

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            imageView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    // MARK: - Loading
    private func setupLoadingView() {
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        loadingView.isHidden = true

        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true

        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }

    // MARK: - Actions
    @objc
    private func pickImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }

    @objc
    private func uploadImage() {
        guard let data = selectedImageData else { return }

        uploadButton.isEnabled = false
        showLoading()

        APIClient.shared.upload(api: .upload, data: data) { [weak self] result in
            DispatchQueue.main.async {
                self?.hideLoading()
                self?.uploadButton.isEnabled = true

                switch result {
                case .success:
                    self?.showAlert(
                        title: "Success",
                        message: "Image uploaded successfully"
                    )

                case .failure(let error):
                    self?.showAlert(
                        title: "Failed",
                        message: error.localizedDescription
                    )
                }
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Loading Helpers
    private func showLoading() {
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }

    private func hideLoading() {
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}

extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else { return }

        imageView.image = image
        selectedImageData = image.jpegData(compressionQuality: 0.8)
        uploadButton.isEnabled = true
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
