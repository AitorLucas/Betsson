//
//  BetsRepository.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 10/07/25.
//

public protocol BetService {
    func loadBets() async throws -> [Bet]
    func saveBets(_ bets: [Bet]) async throws
}

public class BetRepository {

    private let service: BetService
    private let ruleProcessor: BetRuleProcessable

    public init(service: BetService, ruleProcessor: BetRuleProcessable? = nil) {
        self.service = service
        self.ruleProcessor = ruleProcessor ?? BetRuleProcessor()
    }

    var bool = false

    public func updateOdds() async throws -> [Bet] {
//        if bool {
//            throw NSError(domain: "", code: 0, userInfo: nil)
//        }
//        bool.toggle()

        var bets = try await service.loadBets()
        bets = ruleProcessor.process(bets: bets)
        try await service.saveBets(bets)

        return bets
    }

}
