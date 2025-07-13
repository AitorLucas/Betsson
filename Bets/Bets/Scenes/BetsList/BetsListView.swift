//
//  BetsListView.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import UIKit
import BetsCore

protocol BetsListViewDelegate: AnyObject {
    func didSelect(cellModel: BetsListCellModelProtocol)
}

final internal class BetsListView: UIView {

    // MARK: UI
    private let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(type: BetsListCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.text = "Error fetching items"
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Properties
    internal weak var delegate: BetsListViewDelegate?
    private var viewModel: BetsListModelProtocol?

    // MARK: Life Cycle
    @available(*, unavailable)
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) is unavailable")
    }

    internal init() {
        super.init(frame: .zero)
        setupView()
    }

    // MARK: Methods
    internal func startLoading() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.collectionView.alpha = 0
            self?.errorLabel.alpha = 0
        } completion: { [weak self] _ in
            self?.activityIndicatorView.startAnimating()
            self?.collectionView.isHidden = true
            self?.errorLabel.isHidden = true
        }
    }

    internal func stopLoading() {
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.collectionView.alpha = 1
        }
    }

    internal func showError() {
        collectionView.isHidden = true
        errorLabel.isHidden = false
    }

    internal func updateView(with viewModel: BetsListModelProtocol) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }

}

// MARK: - View Code
extension BetsListView: ViewCode {

    internal func configureView() {
        backgroundColor = .systemBackground

        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    internal func buildHierarchy() {
        addSubview(collectionView)
        addSubview(activityIndicatorView)
        addSubview(errorLabel)
    }
    
    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            errorLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            errorLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }

}


// MARK: - UICollectionView DataSource
extension BetsListView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cellModels.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellModel = viewModel?.cellModels[indexPath.item],
              let cell = collectionView.dequeueCell(type: BetsListCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.updateView(with: cellModel)
        return cell
    }

}

// MARK: - UICollectionView Delegate
extension BetsListView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellModel = viewModel?.cellModels[indexPath.item] else { return }
        delegate?.didSelect(cellModel: cellModel)
    }

}
