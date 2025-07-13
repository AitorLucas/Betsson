//
//  BetsListCell.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import UIKit

internal final class BetsListCell: UICollectionViewCell {

    // MARK: UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label.withAlphaComponent(0.7)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: Life Cycle
    @available(*, unavailable)
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) is unavailable")
    }

    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    // MARK: Properties
    internal func updateView(with viewModel: BetsListCellModelProtocol) {
        titleLabel.text = viewModel.title
        imageView.image = UIImage(systemName: viewModel.imageName)?.withRenderingMode(.alwaysTemplate)
    }

}

// MARK: - View Code
extension BetsListCell: ViewCode {

    internal func configureView() {
        backgroundColor = .systemBackground
    }

    internal func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(imageView)
    }

    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 22),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

}
