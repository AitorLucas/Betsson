//
//  BetTyoe.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 13/07/25.
//

import Foundation

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
