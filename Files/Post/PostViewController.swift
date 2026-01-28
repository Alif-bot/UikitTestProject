//
//  PostViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 27/1/26.
//

import UIKit
import QuickLook

final class PostViewController: UIViewController {

    let router: Router
    
    private var downloadedFileURL: URL?
    
    private let stack = UIStackView()
    private let progressView = UIProgressView(progressViewStyle: .default)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
    }
    
    init(
        router: Router
    ) {
        self.router = router
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("")
    }
    
    private func setupUI() {
        stack.axis = .vertical
        stack.spacing = 16

        let buttons = [
            ("Fetch Posts", #selector(fetchPosts)),
            ("Create Post", #selector(createPost)),
            ("Upload Image", #selector(uploadImage)),
            ("Download File", #selector(downloadFile))
        ]

        buttons.forEach {
            let button = UIButton(type: .system)
            button.setTitle($0.0, for: .normal)
            button.addTarget(self, action: $0.1, for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
        
        progressView.isHidden = true
        progressView.progress = 0
        stack.addArrangedSubview(progressView)

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Actions
    
    private func setupBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 20/255, green: 10/255, blue: 40/255, alpha: 1).cgColor,
            UIColor.black.cgColor
        ]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }

    @objc
    private func fetchPosts() {
        APIClient.shared.request(api: .getPosts) { [weak self] (result: Result<[Post], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.router.pushPostDetailsViewController(posts: posts)

                case .failure(let error):
                    print("Error:", error)
                }
            }
        }
    }

    @objc
    private func createPost() {
        router.pushCreatePostViewController()
    }

    @objc
    private func uploadImage() {
        router.pushUploadImageViewController()
    }

    @objc
    private func downloadFile() {

        progressView.progress = 0
        progressView.isHidden = false

        APIClient.shared.download(
            api: .download,
            progress: { [weak self] value in
                self?.progressView.progress = Float(value)
            },
            completion: { [weak self] result in
                self?.progressView.isHidden = true

                switch result {
                case .success(let fileURL):
                    self?.downloadedFileURL = fileURL
                    self?.showToast("Download completed")
                    self?.showFilePreview()

                case .failure(let error):
                    print("DOWNLOAD ERROR:", error)
                }
            }
        )
    }
    
    private func showToast(_ message: String) {
        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.alpha = 0

        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            label.widthAnchor.constraint(lessThanOrEqualToConstant: 240),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])

        UIView.animate(withDuration: 0.3, animations: {
            label.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: [], animations: {
                label.alpha = 0
            }) { _ in
                label.removeFromSuperview()
            }
        }
    }
}

extension PostViewController: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(
        _ controller: QLPreviewController,
        previewItemAt index: Int
    ) -> QLPreviewItem {
        return downloadedFileURL! as QLPreviewItem
    }
    
    private func showFilePreview() {
        guard downloadedFileURL != nil else { return }

        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true)
    }
}
