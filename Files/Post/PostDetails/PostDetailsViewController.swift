//
//  PostDetailsViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 27/1/26.
//

import UIKit

final class PostDetailsViewController: UIViewController {

    private let tableView = UITableView()
    private let posts: [Post]

    // MARK: - Init
    init(
        posts: [Post]
    ) {
        self.posts = posts
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
        setupTableView()
    }

    // MARK: - UI
    private func setupBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 20/255, green: 10/255, blue: 40/255, alpha: 1).cgColor,
            UIColor.black.cgColor
        ]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupUI() {
        title = "Posts"
        view.backgroundColor = .systemBackground
    }

    private func setupTableView() {
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PostDetailsViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        posts.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostCell.identifier,
            for: indexPath
        ) as! PostCell

        cell.configure(with: posts[indexPath.row])
        return cell
    }
}

extension PostDetailsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        UITableView.automaticDimension
    }
}

