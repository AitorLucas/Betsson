//
//  BetsRepository.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 10/07/25.
//

import Foundation

public class BetRepository {

    private let service: BetService
    private let ruleProcessor: BetRuleProcessorProtocol

    public init(service: BetService, ruleProcessor: BetRuleProcessorProtocol? = nil) {
        self.service = service
        self.ruleProcessor = ruleProcessor ?? BetRuleProcessor()
    }

    public func updateOdds() async throws -> [Bet] {
        var bets = try await service.loadBets()
        bets = ruleProcessor.process(bets: bets)
        try await service.saveBets(bets)

        return bets
    }

}
