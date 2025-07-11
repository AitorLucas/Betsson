//
//  YellowCardsRule.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 11/07/25.
//

import Foundation

internal class YellowCardsRule: BetRule {
    internal static func apply(to bet: inout Bet) {
        bet.sellIn -= 1

        if bet.sellIn < 0 {
            bet.quality = max(0, bet.quality - 2)
        }
    }
}
