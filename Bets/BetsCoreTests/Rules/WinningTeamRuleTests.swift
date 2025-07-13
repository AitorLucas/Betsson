//
//  WinningTeamRuleTests.swift
//  BetsCoreTests
//
//  Created by Aitor Eler Lucas on 12/07/25.
//

import XCTest
@testable import BetsCore

final class WinningTeamRuleTests: XCTestCase {

    private var sut: WinningTeamRule.Type!
    private var originalBetValue: Bet!

    override func setUp() async throws {
        sut = WinningTeamRule.self
        originalBetValue = Bet(name: "Winning team", sellIn: 5, quality: 30)
    }

    override func tearDown() async throws {
        sut = nil
        originalBetValue = nil
    }

    func test_valuesRemainUnchanged() {
        // Given
        let original = originalBetValue
        var bet = original

        // When
//        sut.apply(to: (&bet)!)
//
//        // Then
//        XCTAssertEqual(bet, original)
    }
}
