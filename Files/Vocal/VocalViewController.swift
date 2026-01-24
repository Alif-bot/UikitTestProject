//
//  VocalViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

import UIKit

final class VocalViewController: UIViewController {

    private let tableView = UITableView()

    private let mockData: [VocalModel] = [
        .init(name: "Azek", genre: "Hip-hop, Husky"),
        .init(name: "Elara", genre: "Pop, Ethereal"),
        .init(name: "Talia", genre: "Country, Sweet"),
        .init(name: "Bella", genre: "R&B, Powerful"),
        .init(name: "James", genre: "Pop, Captivating")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vocal"
        view.backgroundColor = .black
        setupTableView()
    }

    private func setupTableView() {
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(VocalCell.self, forCellReuseIdentifier: VocalCell.identifier)
        tableView.dataSource = self

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

extension VocalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockData.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: VocalCell.identifier,
            for: indexPath
        ) as! VocalCell
        cell.configure(with: mockData[indexPath.row])
        return cell
    }
}
