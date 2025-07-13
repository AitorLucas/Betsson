//
//  PlayerPerformanceRuleTests.swift
//  BetsCoreTests
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import XCTest
@testable import BetsCore

final class PlayerPerformanceRuleTests: XCTestCase {

    private var sut: PlayerPerformanceRule.Type!
    private var originalBetValue: Bet!

    override func setUp() async throws {
        sut = PlayerPerformanceRule.self
        originalBetValue = Bet(name: "Player performance", sellIn: 9, quality: 4)
    }

    override func tearDown() async throws {
        sut = nil
        originalBetValue = nil
    }

    func test_qualityIncreasesBy1_whenSellInPositive() {
        // Given
        var bet = Bet(name: "Player performance", sellIn: 5, quality: 10)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 11)
        XCTAssertEqual(bet.sellIn, 4)
    }

    func test_qualityIncreasesBy2_afterSellInPasses() {
        // Given
        var bet = Bet(name: "Player performance", sellIn: 0, quality: 10)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 12)
        XCTAssertEqual(bet.sellIn, -1)
    }

    func test_qualityDoesNotExceedFifty() {
        // Given
        var bet = Bet(name: "Player performance", sellIn: 0, quality: 49)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 50)
    }

    func test_qualityRemains50_whenAlreadyAtMaxBeforeExpiration() {
        // Given
        var bet = Bet(name: "Player performance", sellIn: 5, quality: 50)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 50)
        XCTAssertEqual(bet.sellIn, 4)
    }

    func test_qualityIncreasesBy1_whenAt49_andExpired() {
        // Given
        var bet = Bet(name: "Player performance", sellIn: 0, quality: 49)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 50)
        XCTAssertEqual(bet.sellIn, -1)
    }

    func test_qualityRemains50_whenAlreadyAtMaxAndExpired() {
        // Given
        var bet = Bet(name: "Player performance", sellIn: 0, quality: 50)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 50)
        XCTAssertEqual(bet.sellIn, -1)
    }

    func test_negativeQuality_doesNotIncreasePastLimit() {
        // Given
        var bet = Bet(name: "Player performance", sellIn: 3, quality: -5)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, -4)
    }

}

