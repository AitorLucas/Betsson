//
//  StandardBetRuleTests.swift.swift
//  BetsCoreTests
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import XCTest
@testable import BetsCore

final class StandardBetRuleTests: XCTestCase {

    private var sut: StandardBetRule.Type!
    private var originalBetValue: Bet!

    override func setUp() async throws {
        sut = StandardBetRule.self
    }

    override func tearDown() async throws {
        sut = nil
    }

    func test_qualityDecreasesBy1_whenSellInPositive() {
        // Given
        var bet = Bet(name: "Corner kicks", sellIn: 3, quality: 10)

        // When
        sut.apply(to: &bet)

        XCTAssertEqual(bet.quality, 9)
        XCTAssertEqual(bet.sellIn, 2)
    }

    func test_qualityDecreasesBy2_whenSellInExpired() {
        // Given
        var bet = Bet(name: "Offsides", sellIn: 0, quality: 10)

        // When
        sut.apply(to: &bet)

        XCTAssertEqual(bet.quality, 8)
        XCTAssertEqual(bet.sellIn, -1)
    }

    func test_qualityNeverNegative() {
        // Given
        var bet = Bet(name: "Set score", sellIn: 0, quality: 1)

        // When
        sut.apply(to: &bet)

        XCTAssertEqual(bet.quality, 0)
    }

    func test_unknownNewType() {
        // Given
        var bet = Bet(name: "{NEW TYPE}", sellIn: 3, quality: 10)

        // When
        sut.apply(to: &bet)

        // Then
        XCTAssertEqual(bet.quality, 9)
        XCTAssertEqual(bet.sellIn, 2)
    }
}

