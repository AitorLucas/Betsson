//
//  Rules.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 11/07/25.
//

import Foundation

public protocol BetRuleProcessorProtocol {
    func process(bets: [Bet]) -> [Bet]
}

internal class BetRuleProcessor: BetRuleProcessorProtocol {

    private var ruleSet: [BetType: any BetRule.Type] = [
        .playerPerformance: PlayerPerformanceRule.self,
        .totalScore: TotalScoreRule.self,
        .winningTeam: WinningTeamRule.self
    ]

    public func process(bets: [Bet]) -> [Bet] {
        return bets.map { bet in
            var mutableBet = bet
            let rule = ruleSet[bet.type] ?? StandardBetRule.self
            rule.apply(to: &mutableBet)
            return mutableBet
        }
    }

}

// MARK: - BetRule
internal protocol BetRule {
    static func apply(to bet: inout Bet)
}
