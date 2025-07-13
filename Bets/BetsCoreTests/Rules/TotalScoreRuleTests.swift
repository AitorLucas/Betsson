//
//  TotalScoreRuleTests.swift
//  BetsCoreTests
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import XCTest
@testable import BetsCore

final class TotalScoreRuleTests: XCTestCase {

    private var sut: TotalScoreRule.Type!
    private var originalBetValue: Bet!

    override func setUp() async throws {
        sut = TotalScoreRule.self
        originalBetValue = Bet(name: "Player performance", sellIn: 9, quality: 4)
    }

    override func tearDown() async throws {
        sut = nil
        originalBetValue = nil
    }

    func test_qualityIncreasesBy1_whenSellInAbove10() {
        // Given
        var bet = Bet(name: "Total score", sellIn: 11, quality: 10)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 11)
    }

    func test_qualityIncreasesBy2_whenSellInLessThan11() {
        // Given
        var bet = Bet(name: "Total score", sellIn: 10, quality: 10)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 12)
    }

    func test_qualityIncreasesBy3_whenSellInLessThan6() {
        // Given
        var bet = Bet(name: "Total score", sellIn: 5, quality: 10)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 13)
    }

    func test_qualityDropsToZero_afterSellInPasses() {
        // Given
        var bet = Bet(name: "Total score", sellIn: 0, quality: 40)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 0)
    }

    func test_qualityCappedAtFifty() {
        // Given
        var bet = Bet(name: "Total score", sellIn: 5, quality: 49)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 50)
    }

    func test_qualityRemainsFifty_whenAtMax() {
        // Given
        var bet = Bet(name: "Total score", sellIn: 10, quality: 50)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 50)
    }

    func test_sellInDecreasesBy1_eachDay() {
        // Given
        var bet = Bet(name: "Total score", sellIn: 7, quality: 20)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.sellIn, 6)
    }

    func test_qualityRemainsZero_whenAlreadyExpired() {
        // Given
        var bet = Bet(name: "Total score", sellIn: -1, quality: 25)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 0)
        XCTAssertEqual(bet.sellIn, -2)
    }

}
