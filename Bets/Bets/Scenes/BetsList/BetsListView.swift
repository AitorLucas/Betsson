//
//  BetsListView.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import UIKit
import BetsCore

internal protocol BetsListViewDelegate: AnyObject {
    func didSelect(cellModel: BetsListCellModelProtocol)
}

internal final class BetsListView: UIView {

    // MARK: UI
    private let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(type: BetsListCell.self)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.isHidden = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .label.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.text = "Error fetching items"
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Properties
    private var viewModel: BetsListModelProtocol?
    private var currentState: ViewState?
    private var transitionID = UUID()
    internal weak var delegate: BetsListViewDelegate?

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
    private func transition(to newState: ViewState) {
        guard newState != currentState else { return }
        currentState = newState

        let thisTransitionID = UUID()
        transitionID = thisTransitionID

        let views: [(view: UIView, shouldShow: Bool)] = [
            (collectionView, newState == .content),
            (activityIndicatorView, newState == .loading),
            (errorLabel, newState == .error)
        ]

        views.forEach { $0.view.isHidden = false }

        UIView.animate(withDuration: 0.2) {
            views.forEach { view, shouldShow in
                view.alpha = shouldShow ? 1 : 0
            }
        } completion: { [weak self] _ in
            guard let self = self,
                  self.transitionID == thisTransitionID else { return }
            views.forEach { view, shouldShow in
                view.isHidden = !shouldShow
            }
            if newState == .loading {
                self.activityIndicatorView.startAnimating()
            } else {
                self.activityIndicatorView.stopAnimating()
            }
        }
    }

    internal func startLoading() {
        transition(to: .loading)
    }

    internal func showError() {
        transition(to: .error)
    }

    internal func updateView(with viewModel: BetsListModelProtocol) {
        transition(to: .content)
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
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}

// MARK: - UICollectionView DataSource
extension BetsListView: UICollectionViewDataSource {

    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cellModels.count ?? 0
    }

    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellModel = viewModel?.cellModels[indexPath.item] else { return }
        delegate?.didSelect(cellModel: cellModel)
    }

}
