//
//  HitListViewController.swift
//
//  Created by Giorgi Kratsashvili on 12/2/23.
//

import Combine
import DI
import Domain
import UIKit

final class HitListViewController: UIViewController {
    fileprivate enum Section {
        case main
    }

    @Inject(container: .viewModels) private var viewModel: HitListViewModel

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, HitEntity>!
    private var snapshot: NSDiffableDataSourceSnapshot<Section, HitEntity>!
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.viewDidLoad()
    }
}

fileprivate extension HitListViewController {
    func configure() {
        configureNavigation()
        configureHierarchy()
        configureDataSource()
        configureSnapshot()
        bind()
    }

    func configureNavigation() {
        navigationItem.title = "Hits"
    }

    func configureHierarchy() {
        collectionView = .init(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, HitEntity>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: HitEntity) -> UICollectionViewCell? in

            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCell.reuseIdentifier,
                for: indexPath) as? TextCell
                else { fatalError("Cannot create new cell") }

            cell.label.text = item.user
            cell.contentView.backgroundColor = .blue
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)

            return cell
        }
    }

    func configureSnapshot() {
        snapshot = .init()
        snapshot.appendSections([.main])
    }

    func bind() {
        cancellable = viewModel.$latestHitPage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self, case .loaded(let result) = $0 else { return }
                snapshot.appendItems(result)
                dataSource.apply(snapshot, animatingDifferences: true)
            }
    }

    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(54))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension HitListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.cellWillDisplay(at: indexPath.row)
    }
}
