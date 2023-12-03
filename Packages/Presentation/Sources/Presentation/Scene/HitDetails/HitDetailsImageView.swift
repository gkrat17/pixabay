//
//  HitDetailsImageView.swift
//
//  Created by Giorgi Kratsashvili on 12/3/23.
//

import Domain
import Kingfisher
import UIKit

final class HitDetailsImageView: UITableViewCell {
    private let image = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HitDetailsImageView {
    func configure(with url: URL) {
        image.kf.setImage(with: url)
    }
}

fileprivate extension HitDetailsImageView {
    func configure() {
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
