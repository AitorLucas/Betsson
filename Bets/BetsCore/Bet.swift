//
//  Bet.swift
//  BetsCore
//
//  Created by Aitor Eler Lucas on 10/07/25.
//

import Foundation

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

}
