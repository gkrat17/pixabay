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
        title = "Hits"
    }

    func configureHierarchy() {
        collectionView = .init(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(HitListItemView.self, forCellWithReuseIdentifier: HitListItemView.reuseIdentifier)
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, HitEntity>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, entity: HitEntity) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HitListItemView.reuseIdentifier,
                for: indexPath) as? HitListItemView
            else { fatalError() }
            cell.configure(with: entity)
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let entity = viewModel.entity(at: indexPath.row) else { return }
        let viewController = HitDetailsViewController()
        viewController.configure(with: entity)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
