//
//  BetService.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 13/07/25.
//

import Foundation

public protocol BetService {
    func loadBets() async throws -> [Bet]
    func saveBets(_ bets: [Bet]) async throws
}
