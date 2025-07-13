//
//  BetsListCell.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import UIKit

internal final class BetsListCell: UICollectionViewCell {

    // MARK: UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label.withAlphaComponent(0.7)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let qualityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .label.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sellInLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .label.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        nameLabel.text = viewModel.nameText
        sellInLabel.text = viewModel.sellInText
        qualityLabel.text = viewModel.qualityText
        imageView.image = UIImage(systemName: viewModel.imageName)?.withRenderingMode(.alwaysTemplate)
    }

}

// MARK: - View Code
extension BetsListCell: ViewCode {

    internal func configureView() {
        backgroundColor = .systemBackground
    }

    internal func buildHierarchy() {
        addSubview(nameLabel)
        addSubview(imageView)
        addSubview(stackView)
        stackView.addArrangedSubview(qualityLabel)
        stackView.addArrangedSubview(sellInLabel)
    }

    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 22),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            stackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }

}
