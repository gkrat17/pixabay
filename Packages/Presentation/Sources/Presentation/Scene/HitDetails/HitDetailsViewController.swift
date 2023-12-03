//
//  HitDetailsViewController.swift
//
//  Created by Giorgi Kratsashvili on 12/3/23.
//

import Combine
import DI
import Domain
import UIKit

final class HitDetailsViewController: UIViewController {
    fileprivate enum Section {
        case main
        case details
    }

    fileprivate enum Item: Hashable {
        case image(url: URL)
        case info(title: String, description: String)
    }

    @Inject(container: .viewModels) private var viewModel: HitDetailsViewModel

    private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension HitDetailsViewController {
    func configure(with entity: HitEntity) {
        viewModel.entity = entity
    }
}

fileprivate extension HitDetailsViewController {
    func configure() {
        configureNavigation()
        configureHierarchy()
        configureDataSource()
        bind()
    }

    func configureNavigation() {
        navigationItem.title = "Hit details"
    }

    func configureHierarchy() {
        tableView = .init(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell? in

            let cell = tableView.dequeueReusableCell(
                withIdentifier: UITableViewCell.reuseIdentifier,
                for: indexPath)

            switch item {
            case .image(url: let url):
                cell.textLabel?.text = "URL: \(url)"
            case .info(title: let title, description: let description):
                cell.textLabel?.text = "\(title): \(description)"
            }

            return cell
        }
    }

    func bind() {
        cancellable = viewModel.$entity
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main, .details])
                snapshot.appendItems(mainSectionItems($0), toSection: .main)
                snapshot.appendItems(detailsSectionItems($0), toSection: .details)
                dataSource.apply(snapshot, animatingDifferences: false)
            }
    }

    func mainSectionItems(_ entity: HitEntity) -> [Item] {
        [image(url: entity.pageURL ?? entity.previewURL),
         info(title: "Size", description: entity.imageSize),
         info(title: "Type", description: entity.type),
         info(title: "Tags", description: entity.tags)].compactMap { $0 }
    }

    func detailsSectionItems(_ entity: HitEntity) -> [Item] {
        [info(title: "User", description: entity.user),
         info(title: "Views", description: entity.views),
         info(title: "Likes", description: entity.likes),
         info(title: "Comments", description: entity.comments),
         info(title: "Favorites", description: entity.collections),
         info(title: "Downloads", description: entity.downloads)].compactMap { $0 }
    }

    func image(url: String?) -> Item? {
        if let url = url, let url = URL(string: url) {
            .image(url: url)
        } else {
            nil
        }
    }

    func info(title: String, description: CustomStringConvertible?) -> Item? {
        if let description = description {
            .info(title: "Size", description: description.description)
        } else {
            nil
        }
    }
}
