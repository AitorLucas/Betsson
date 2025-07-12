//
//  BetsListView.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import UIKit
import BetsCore

protocol BetsListViewDelegate: AnyObject {

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
        } completion: { [weak self] _ in
            self?.activityIndicatorView.startAnimating()
            self?.collectionView.isHidden = true
        }

    }

    internal func stopLoading() {
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.collectionView.alpha = 1
        }
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
    }
    
    internal func buildHierarchy() {
        addSubview(collectionView)
        addSubview(activityIndicatorView)
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
    }

}


// MARK: - UICollectionView Data Source

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
