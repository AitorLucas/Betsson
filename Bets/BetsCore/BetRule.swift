//
//  BetRule.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 13/07/25.
//

import Foundation

internal protocol BetRule {
    static func apply(to bet: inout Bet)
}
