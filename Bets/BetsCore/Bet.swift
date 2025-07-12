//
//  Bet.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 10/07/25.
//

public struct Bet: Equatable {
    public let name: String
    public var sellIn: Int
    public var quality: Int
    public let type: BetType

    public init(name: String, sellIn: Int, quality: Int) {
        self.name = name
        self.sellIn = sellIn
        self.quality = quality
        self.type = BetType(rawValue: name) ?? .defaultType
    }

//    internal mutating func updateSellIn(value: Int) {
//        self.sellIn = value
//    }
//
//    internal mutating func updateQuality(value: Int) {
//        self.quality = value
//    }
}

public enum BetType: String {
    case winningTeam = "Winning team"
    case totalScore = "Total score"
    case playerPerformance = "Player performance"
    case firstGoalScorer = "First goal scorer"
    case numberOfFouls = "Number of fouls"
    case cornerKicks = "Corner kicks"
    case yellowCards = "Yellow cards"
    case redCards = "Red cards"
    case offsides = "Offsides"
    case penalties = "Penalties"
    case halfTimeScore = "Half-time score"
    case cleanSheet = "Clean sheet"
    case hatTrick = "Hat trick"
    case numberOfSetsWon = "Number of sets won"
    case numberOfAces = "Number of aces"
    case setScore = "Set score"
    case defaultType
}
