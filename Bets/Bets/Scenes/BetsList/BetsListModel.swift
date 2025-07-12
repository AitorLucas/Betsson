//
//  BetsListModel.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import Foundation
import BetsCore

internal protocol BetsListModelProtocol {
    var cellModels: [BetsListCellModelProtocol] { get }
}

struct BetsListModel: BetsListModelProtocol {
    let cellModels: [BetsListCellModelProtocol]

    init(bets: [Bet]) {
        self.cellModels = bets.map({ BetsListCellModel(bet: $0) })
    }
}
