import XCTest
@testable import BetsCore

class Service: BetService {
    func loadBets() async throws -> [BetsCore.Bet] {
        return [
            Bet(name: "Normal", sellIn: 5, quality: 10),
            Bet(name: "Winning team", sellIn: 5, quality: 10),
            Bet(name: "Total score", sellIn: 5, quality: 20),
            Bet(name: "Player performance", sellIn: 0, quality: 49)
        ]

//        return [
//            Bet(name: "Winning team", sellIn: 8, quality: 15),
//            Bet(name: "Total score", sellIn: 5, quality: 26),
//            Bet(name: "Player performance", sellIn: 9, quality: 4),
//            Bet(name: "First goal scorer", sellIn: 10, quality: 49),
//            Bet(name: "Number of fouls", sellIn: 4, quality: 21),
//            Bet(name: "Corner kicks", sellIn: 9, quality: 32),
//            Bet(name: "Yellow cards", sellIn: 0, quality: 45),
//            Bet(name: "Red cards", sellIn: 2, quality: 11),
//            Bet(name: "Offsides", sellIn: 2, quality: 14),
//            Bet(name: "Penalties", sellIn: 4, quality: 10),
//            Bet(name: "Half-time score", sellIn: 1, quality: 42),
//            Bet(name: "Clean sheet", sellIn: 10, quality: 34),
//            Bet(name: "Hat trick", sellIn: 9, quality: 32),
//            Bet(name: "Number of sets won", sellIn: 8, quality: 17),
//            Bet(name: "Number of aces", sellIn: 6, quality: 46),
//            Bet(name: "Set score", sellIn: 9, quality: 12)
//        ]
    }

    func saveBets(_ bets: [BetsCore.Bet]) async throws {

    }
}

class BetsCoreTests: XCTestCase {

    let betService = BetRepository(service: Service())

    func testEquivalence() {
        let testBets = [
            Bet(name: "Normal", sellIn: 5, quality: 10),
            Bet(name: "Winning team", sellIn: 5, quality: 10),
            Bet(name: "Total score", sellIn: 5, quality: 20),
            Bet(name: "Player performance", sellIn: 0, quality: 49)
        ]

//        let result1 = betService.og(bets: testBets)
//        let result2 = betService.og_mut(bets: testBets)

//        XCTAssertEqual(result1, result2)
    }

}
