//
//  BetsRepositoryTests.swift
//  BetsCoreTests
//
//  Created by Aitor Eler Lucas on 11/07/25.
//

import XCTest
@testable import BetsCore

final class BetRepositoryTests: XCTestCase {

    private var service: MockService!
    private var sut: BetRepository!

    override func setUp() async throws {
        service = MockService()
        sut = BetRepository(service: service)
    }

    override func tearDown() async throws {
        sut = nil
        service = nil
    }

    func test_updateOdds_appliesRulesAndSavesThem_GivenValues() async throws {
        // Given
        service.betsToLoad = [
            Bet(name: "Player performance", sellIn: 1, quality: 48),
            Bet(name: "Total score", sellIn: 5, quality: 45),
            Bet(name: "Yellow cards", sellIn: 0, quality: 10),
            Bet(name: "Red cards", sellIn: 5, quality: 10)
        ]

        // When
        let updated = try await sut.updateOdds()

        // Then
        XCTAssertEqual(updated.count, 4)
        XCTAssertEqual(service.savedBets, updated)

//        let player = updated[0]
//        XCTAssertEqual(player.quality, 50)
//        XCTAssertEqual(player.sellIn, 0)
//
//        let total = updated[1]
//        XCTAssertEqual(total.quality, 48) // +3
//        XCTAssertEqual(total.sellIn, 4)
//
//        let yellow = updated[2]
//        XCTAssertEqual(yellow.sellIn, -1)
//        XCTAssertEqual(yellow.quality, 8) // down by 2
//
//        let red = updated[3]
//        XCTAssertEqual(red.sellIn, 4)
//        XCTAssertEqual(red.quality, 9) // Standard rule
    }

    func test_updateOdds_appliesRulesAndSavesThem_OriginalValues() async throws {
        // Given
        service.saveOriginalsBets()

        // When
        let updated = try await sut.updateOdds()

        // Then
        XCTAssertEqual(updated.count, 16)
        XCTAssertEqual(service.savedBets, updated)
    }

}
