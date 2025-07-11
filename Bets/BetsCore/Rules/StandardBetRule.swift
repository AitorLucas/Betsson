//
//  StandardBetRule.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 11/07/25.
//

import Foundation

internal class StandardBetRule: BetRule {
    internal static func apply(to bet: inout Bet) {
        if bet.quality > 0 {
            bet.quality -= 1
        }

        bet.sellIn -= 1

        if bet.sellIn < 0,
           bet.quality > 0 {
            bet.quality -= 1
        }
    }
}
