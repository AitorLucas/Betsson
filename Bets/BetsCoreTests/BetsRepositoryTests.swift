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

    func test_updateOdds_appliesRulesAndSavesThem_givenValues() async throws {
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
    }

    func test_updateOdds_appliesRulesAndSavesThem_originalValues() async throws {
        // Given
        service.saveOriginalsBets()

        // When
        let updated = try await sut.updateOdds()

        // Then
        XCTAssertEqual(updated.count, 16)
        XCTAssertEqual(service.savedBets, updated)
    }

    func test_legacyProcessorIsEqualToNew_originalValues() async throws {
        // Given
        let legacyRepository = BetRepository(service: service, ruleProcessor: LegacyRuleProcessor())
        service.saveOriginalsBets()

        // When
        let sutUpdated = try await sut.updateOdds()
        let legacyUpdated = try await legacyRepository.updateOdds()

        // Then
        XCTAssertEqual(sutUpdated, legacyUpdated)
    }

    func test_legacyProcessorIsEqualToNew_randomValues() async throws {
        // Given
        let legacyRepository = BetRepository(service: service, ruleProcessor: LegacyRuleProcessor())
        service.betsToLoad = [
            Bet(name: "Winning team", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Total score", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Player performance", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "First goal scorer", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Number of fouls", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Corner kicks", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Yellow cards", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Red cards", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Offsides", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Penalties", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Half-time score", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Clean sheet", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Hat trick", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Number of sets won", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Number of aces", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "Set score", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50)),
            Bet(name: "NEW TYPE", sellIn: Int.random(in: -10...10), quality: Int.random(in: -50...50))
        ]

        // When
        let sutUpdated = try await sut.updateOdds()
        let legacyUpdated = try await legacyRepository.updateOdds()

        // Then
        XCTAssertEqual(sutUpdated, legacyUpdated)
    }

}
