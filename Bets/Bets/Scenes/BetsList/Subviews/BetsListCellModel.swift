//
//  BetsListCellModel.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import Foundation
import BetsCore

internal protocol BetsListCellModelProtocol {
    var nameText: String { get }
    var imageName: String { get }
    var sellInText: String { get }
    var qualityText: String { get }
}

internal struct BetsListCellModel: BetsListCellModelProtocol {

    internal let nameText: String
    internal let imageName: String
    internal let sellInText: String
    internal let qualityText: String

    internal init(bet: Bet) {
        self.nameText = bet.name
        self.sellInText = "Sell-In: \(bet.sellIn)"
        self.qualityText = "Quality: \(bet.quality)"

        switch bet.type {
        case .winningTeam:
            imageName = "trophy.fill"
        case .totalScore:
            imageName = "number.circle"
        case .playerPerformance:
            imageName = "person.crop.circle.badge.checkmark"
        case .firstGoalScorer:
            imageName = "soccerball"
        case .numberOfFouls:
            imageName = "hand.raised.fill"
        case .cornerKicks:
            imageName = "arrow.up.left.and.arrow.down.right"
        case .yellowCards:
            imageName = "square.fill"
        case .redCards:
            imageName = "square.fill"
        case .offsides:
            imageName = "flag.checkered"
        case .penalties:
            imageName = "exclamationmark.octagon.fill"
        case .halfTimeScore:
            imageName = "clock.badge"
        case .cleanSheet:
            imageName = "shield.lefthalf.filled"
        case .hatTrick:
            imageName = "3.circle.fill"
        case .numberOfSetsWon:
            imageName = "circle.grid.3x3.fill"
        case .numberOfAces:
            imageName = "bolt.fill"
        case .setScore:
            imageName = "square.grid.2x2.fill"
        case .defaultType:
            imageName = "questionmark.circle"
        }
    }
}
