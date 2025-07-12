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
    private let ruleProcessor: BetRuleProcessor

    public init(service: BetService, ruleProcessor: BetRuleProcessor? = nil) {
        self.service = service
        self.ruleProcessor = ruleProcessor ?? BetRuleProcessor()
    }

    public func updateOdds() async throws -> [Bet] {
        var bets = try await service.loadBets()
//        let betsInit = bets

        bets = ruleProcessor.process(bets: bets)

//        let oldResult = og(bets: betsInit)
//        print("Results match:", bets == oldResult)
//        print("Before:\n", betsInit)
//        print("RuleProcessor:\n", bets)
//        print("OldResult:\n", oldResult)

        try await service.saveBets(bets)
        return bets
    }

    internal func og(bets: [Bet]) -> [Bet] {
        var bets = bets

        for i in 0 ..< bets.count {
            if bets[i].name != "Player performance",
               bets[i].name != "Total score" {
                if bets[i].quality > 0 {
                    if bets[i].name != "Winning team" {
                        bets[i].quality = bets[i].quality - 1
                    }
                }
            } else {
                if bets[i].quality < 50 {
                    bets[i].quality = bets[i].quality + 1

                    if bets[i].name == "Total score" {
                        if bets[i].sellIn < 11 {
                            // Unnecessary
                            if bets[i].quality < 50 {
                                bets[i].quality = bets[i].quality + 1
                            }
                        }

                        if bets[i].sellIn < 6 {
                            // Unnecessary
                            if bets[i].quality < 50 {
                                bets[i].quality = bets[i].quality + 1
                            }
                        }
                    }
                }
            }

            if bets[i].name != "Winning team" {
                bets[i].sellIn = bets[i].sellIn - 1
            }

            if bets[i].sellIn < 0 {
                if bets[i].name != "Player performance" {
                    if bets[i].name != "Total score" {
                        if bets[i].quality > 0 {
                            if bets[i].name != "Winning team" {
                                bets[i].quality = bets[i].quality - 1
                            }
                        }
                    } else {
                        bets[i].quality = bets[i].quality - bets[i].quality
                    }
                } else {
                    if bets[i].quality < 50 {
                        bets[i].quality = bets[i].quality + 1
                    }
                }
            }
        }

        return bets
    }
}
