//
//  BetsListViewModel.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import Foundation
import BetsCore

internal protocol BetsListViewModelDelegate: AnyObject {
    func didUpdateState(_ state: BetsListViewModel.State)
}

internal final class BetsListViewModel {

    // MARK: Properties
    private let repository: BetRepository
    internal weak var delegate: BetsListViewModelDelegate?
    private var data: [Bet]?

    // MARK: Enum
    internal enum State {
        case loading
        case content([BetsListCellModelProtocol])
        case error
    }

    // MARK: Life Cycle
    internal init(repository: BetRepository) {
        self.repository = repository
    }

    // MARK: Methods
    internal func loadData() {
        delegate?.didUpdateState(.loading)

        Task {
            do {
                let bets = try await repository.updateOdds()
                self.data = bets
                let cellModels = bets.map { BetsListCellModel(bet: $0) }
                await MainActor.run {
                    self.delegate?.didUpdateState(.content(cellModels))
                }
            } catch {
                await MainActor.run {
                    self.delegate?.didUpdateState(.error)
                }
            }
        }
    }

    internal func betForIndex(_ index: Int) -> Bet? {
        guard let data = data,
              index < data.count else { return nil }
        return data[index]
    }

}
