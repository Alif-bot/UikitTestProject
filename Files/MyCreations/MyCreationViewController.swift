//
//  MyCreationViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class MyCreationViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 36) / 2, height: 180)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private let mockData: [CreationModel] = [
        .init(date: "Jan 24, 12:01 AM", status: "Completed"),
        .init(date: "Jan 23, 11:58 PM", status: "Completed"),
        .init(date: "Jan 23, 11:53 PM", status: "Completed"),
        .init(date: "Jan 23, 11:51 PM", status: "Completed")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Creations"
        view.backgroundColor = .black
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .black
        collectionView.register(CreationCell.self, forCellWithReuseIdentifier: CreationCell.identifier)
        collectionView.dataSource = self

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MyCreationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mockData.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CreationCell.identifier,
            for: indexPath
        ) as! CreationCell
        cell.configure(with: mockData[indexPath.item])
        return cell
    }
}
