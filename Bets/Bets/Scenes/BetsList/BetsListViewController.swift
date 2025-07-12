//
//  BetsListViewController.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import UIKit
import BetsCore

final internal class BetsListViewController: UIViewController {

    // MARK: Properties
    private let repository = BetRepository(service: RemoteBetService())
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

        loadData()
    }

    // MARK: Methods

    @objc
    private func loadData() {
        customView.startLoading()

        Task {
            do {
                let items = try await self.repository.updateOdds()
                await MainActor.run { [weak self] in
                    let viewModel = BetsListModel(bets: items)
                    self?.customView.updateView(with: viewModel)
                    self?.customView.stopLoading()
                }
            } catch {
                print("Error fetching items.")
            }
        }
    }

}

// MARK: - BetsListView Delegate

extension BetsListViewController: BetsListViewDelegate {

}

