//
//  Rules.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 11/07/25.
//

import Foundation

public class BetRuleProcessor {
    private var ruleSet: [BetType: any BetRule.Type] = [
        .totalScore: TotalScoreRule.self,
        .playerPerformance: PlayerPerformanceRule.self,
        .yellowCards: YellowCardsRule.self,
        .winningTeam: WinningTeamRule.self
    ]

    public func process(bets: [Bet]) -> [Bet] {
        return bets.map { bet in
            var mutableBet = bet
            if let rule = ruleSet[bet.type] {
                rule.apply(to: &mutableBet)
            } else {
                StandardBetRule.apply(to: &mutableBet)
            }
            return mutableBet
        }
    }
}

// MARK: - BetRule

public protocol BetRule {
    static func apply(to bet: inout Bet)
}

// extension BetRule {
//    // MARK: Hashable
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(Self.appliedTo)
//    }
//
//    // MARK: Equatable
//    static func ==(lhs: Self, rhs: Self) -> Bool {
//        Self.appliedTo == Self.appliedTo
//    }
// }
