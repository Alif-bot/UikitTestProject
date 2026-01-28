//
//  CreatePostViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 27/1/26.
//

import UIKit

final class CreatePostViewController: UIViewController {

    private let titleField = UITextField()
    private let bodyTextView = UITextView()
    private let postButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI
    private func setupUI() {
        title = "Create Post"
        view.backgroundColor = .systemBackground

        titleField.placeholder = "Post title"
        titleField.borderStyle = .roundedRect

        bodyTextView.font = .systemFont(ofSize: 16)
        bodyTextView.layer.borderWidth = 1
        bodyTextView.layer.borderColor = UIColor.systemGray4.cgColor
        bodyTextView.layer.cornerRadius = 8

        postButton.setTitle("Post", for: .normal)
        postButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        postButton.addTarget(self, action: #selector(postTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [
            titleField,
            bodyTextView,
            postButton
        ])

        stack.axis = .vertical
        stack.spacing = 16

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            bodyTextView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }

    // MARK: - Action
    @objc private func postTapped() {
        guard
            let title = titleField.text, !title.isEmpty,
            !bodyTextView.text.isEmpty
        else {
            showAlert(title: "Error", message: "Please fill all fields")
            return
        }

        let post = Post(id: nil, title: title, body: bodyTextView.text)
        let data = try! JSONEncoder().encode(post)

        APIClient.shared.request(api: .createPost, body: data) { [weak self] (result: Result<Post, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.showAlert(
                        title: "Success",
                        message: "Post created with ID: \(response.id ?? 0)"
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

    private func showAlert(
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
