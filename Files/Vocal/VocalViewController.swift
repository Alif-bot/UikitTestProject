//
//  VocalViewController.swift
//  TestProject
//
//  Created by Md Alif Hossain on 25/1/26.
//

import UIKit

final class VocalViewController: UIViewController, UITableViewDelegate {
    
    let router: Router
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var actionButtonsStack: UIStackView!
    
    private var mockData = VocalModel.mock
    
    init(
        router: Router
    ) {
        self.router = router
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeader()
        setupActionButtons()
        setupVocalLibraryLabel()
        setupTableView()
        
        tableView.delegate = self
    }
    
    private let vocalLibraryContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let vocalLibraryLabel: UILabel = {
        let label = UILabel()
        label.text = "Vocal Library"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private func setupBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 20/255, green: 10/255, blue: 40/255, alpha: 1).cgColor,
            UIColor.black.cgColor
        ]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupHeader() {
        let titleLabel = UILabel()
        titleLabel.text = "Vocal"
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 28)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Create songs inspired by a reference vocal"
        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = .systemFont(ofSize: 14)
        
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        closeButton.layer.cornerRadius = 16
        closeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let headerStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        headerStack.axis = .vertical
        headerStack.spacing = 8
        
        view.addSubview(headerStack)
        view.addSubview(closeButton)
        
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupActionButtons() {
        func makeButton(title: String, icon: String) -> UIButton {
            let button = UIButton(type: .system)
            button.setTitle("  \(title)", for: .normal)
            button.setImage(UIImage(systemName: icon), for: .normal)
            button.tintColor = .white
            button.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.7)
            button.layer.cornerRadius = 14
            button.heightAnchor.constraint(equalToConstant: 48).isActive = true
            return button
        }
        
        let upload = makeButton(title: "Upload Audio", icon: "music.note")
        let youtube = makeButton(title: "Youtube Link", icon: "link")
        
        let stack = UIStackView(arrangedSubviews: [upload, youtube])
        stack.spacing = 12
        stack.distribution = .fillEqually
        
        actionButtonsStack = stack
        view.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupVocalLibraryLabel() {
        view.addSubview(vocalLibraryContainer)
        vocalLibraryContainer.addSubview(vocalLibraryLabel)
        
        vocalLibraryContainer.translatesAutoresizingMaskIntoConstraints = false
        vocalLibraryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vocalLibraryContainer.topAnchor.constraint(equalTo: actionButtonsStack.bottomAnchor, constant: 24),
            vocalLibraryContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vocalLibraryContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vocalLibraryContainer.heightAnchor.constraint(equalToConstant: 48),
            
            vocalLibraryLabel.leadingAnchor.constraint(equalTo: vocalLibraryContainer.leadingAnchor, constant: 20),
            vocalLibraryLabel.centerYAnchor.constraint(equalTo: vocalLibraryContainer.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(VocalCell.self, forCellReuseIdentifier: VocalCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = 72
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: vocalLibraryContainer.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func presentUseSheet(for model: VocalModel) {
        let sheetVC = UIViewController()
        sheetVC.view.backgroundColor = .systemBackground
        sheetVC.modalPresentationStyle = .pageSheet

        // Half-sheet style
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 16
        }

        // Labels for singer name and genre
        let nameLabel = UILabel()
        nameLabel.text = model.name
        nameLabel.font = .boldSystemFont(ofSize: 22)
        nameLabel.textAlignment = .center

        let genreLabel = UILabel()
        genreLabel.text = model.genre
        genreLabel.font = .systemFont(ofSize: 18)
        genreLabel.textColor = .gray
        genreLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [nameLabel, genreLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center

        sheetVC.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: sheetVC.view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: sheetVC.view.centerYAnchor)
        ])

        present(sheetVC, animated: true)
    }
}

extension VocalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: VocalCell.identifier,
            for: indexPath
        ) as! VocalCell
        let model = mockData[indexPath.row]
        cell.configure(with: model)
        cell.onUseTapped = { [weak self] in
            guard let self = self else { return }
            self.presentUseSheet(for: model)
        }
        return cell
    }
}

extension VocalViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect row with animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Push details view controller
        let selected = mockData[indexPath.row]
        router
            .pushVocalDetailsViewContoller(
                name: selected.name,
                genre: selected.genre,
                imageURL: selected.imageURL
            ) { newName in
                self.mockData[indexPath.row].name = newName
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
    }
}
