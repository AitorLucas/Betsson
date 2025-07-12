//
//  YellowCardsRuleTests.swift
//  BetsCoreTests
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import XCTest
@testable import BetsCore

final class YellowCardsRuleTests: XCTestCase {

    private var sut: YellowCardsRule.Type!
    private var originalBetValue: Bet!

    override func setUp() async throws {
        sut = YellowCardsRule.self
        originalBetValue = Bet(name: "Player performance", sellIn: 9, quality: 4)
    }

    override func tearDown() async throws {
        sut = nil
        originalBetValue = nil
    }

    func test_noPenalty_whenSellInPositive() {
        // Given
        var bet = Bet(name: "Yellow cards", sellIn: 2, quality: 10)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 10)
        XCTAssertEqual(bet.sellIn, 1)
    }

    func test_penaltyApplied_whenSellInZero() {
        // Given
        var bet = Bet(name: "Yellow cards", sellIn: 0, quality: 10)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 8)
        XCTAssertEqual(bet.sellIn, -1)
    }

    func test_qualityNeverNegative() {
        // Given
        var bet = Bet(name: "Yellow cards", sellIn: -1, quality: 1)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 0)
    }
}
