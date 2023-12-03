//
//  HitListItemView.swift
//
//  Created by Giorgi Kratsashvili on 12/3/23.
//

import Domain
import Kingfisher
import UIKit

final class HitListItemView: UICollectionViewCell {
    private let image = UIImageView()
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HitListItemView {
    func configure(with entity: HitEntity) {
        if let url = entity.previewURL,
           let url = URL(string: url) {
            image.kf.setImage(with: url)
        } else {
            image.image = nil
        }
        label.text = entity.user
    }
}

fileprivate extension HitListItemView {
    func configure() {
        addSubview(image)
        addSubview(label)
        configureImage()
        configureLabel()
    }

    func configureImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func configureLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
}
