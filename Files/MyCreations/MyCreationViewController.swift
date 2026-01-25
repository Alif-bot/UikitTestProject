//
//  MyCreationViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class MyCreationViewController: UIViewController {

    private let collectionView: UICollectionView
    private let viewModel: MyCreationViewModel

    init(viewModel: MyCreationViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - 36) / 2,
            height: 180
        )
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "My Creations"
        view.backgroundColor = .black
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

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.numberOfItems()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CreationCell.identifier,
            for: indexPath
        ) as! CreationCell

        let vm = viewModel.item(at: indexPath.item)
        cell.configure(with: vm)

        viewModel.loadImage(at: indexPath.item) { image in
            cell.setImage(image)
        }

        return cell
    }
}
