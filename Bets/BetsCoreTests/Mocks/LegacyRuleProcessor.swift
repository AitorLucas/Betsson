//
//  LegacyRuleProcessor.swift
//  Bets
//
//  Created by Aitor Eler Lucas on 13/07/25.
//

@testable import BetsCore

internal final class LegacyRuleProcessor: BetRuleProcessorProtocol {

    internal func process(bets: [Bet]) -> [Bet] {
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
