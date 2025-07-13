//
//  BetsListViewController.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import UIKit
import BetsCore

internal final class BetsListViewController: UIViewController {

    // MARK: Properties
    private let viewModel = BetsListViewModel(repository: BetRepository(service: RemoteBetService()))
    private lazy var customView: BetsListView = {
        let view = BetsListView()
        view.delegate = self
        return view
    }()

    // MARK: Life Cycle
    internal override func loadView() {
        self.view = customView

        title = "Odds"
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadData))
        navigationItem.rightBarButtonItem = reloadButton
        navigationItem.rightBarButtonItem?.tintColor = .label.withAlphaComponent(0.7)
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        loadData()
    }

    // MARK: Methods
    @objc
    private func loadData() {
        viewModel.loadData()
    }

}

// MARK: - BetsListView Delegate
extension BetsListViewController: BetsListViewDelegate {

    internal func didSelectItem(at index: IndexPath) {
        guard let selectedBet = viewModel.betForIndex(index.row) else { return }
        print("Selected Bet: \(selectedBet)")
    }

}

// MARK: - BetsListViewModel Delegate
extension BetsListViewController: BetsListViewModelDelegate {

    func didUpdateState(_ state: BetsListViewModel.State) {
        switch state {
        case .content(let cellModels):
            customView.updateView(with: cellModels)
        case .loading:
            customView.startLoading()
        case .error:
            customView.showError()
        }
    }

}
