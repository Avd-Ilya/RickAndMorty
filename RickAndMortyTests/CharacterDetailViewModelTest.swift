//
//  CharacterDetailViewModelTets.swift
//  RickAndMortyTests
//
//  Created by Ilya on 17.06.2022.
//

import XCTest
import Combine
@testable import RickAndMorty

class CharacterDetailViewModelTest: XCTestCase {

    var sut: CharacterDetailViewModel!
    var charactersNetworkService: MockCharactersNetworkService!
    var characterId = 0
    
    override func setUp() {
        super.setUp()
        charactersNetworkService = MockCharactersNetworkService()
        sut = .init(characterId: characterId, charactersNetworkService: charactersNetworkService)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testEventOnAppear() {
        
        let characters = [
            CharacterModel(id: characterId, name: "testName", status: "testStatus", species: "testSpecies", gender: "testGender", location: "testLocation", image: "testImage", episode: ["1"])
        ]
        charactersNetworkService.fetchCharactersResult = CurrentValueSubject(characters).eraseToAnyPublisher()
        
        XCTAssertEqual(sut.state, .idle)
        
        sut.sendEvent(event: .onAppear)
        XCTAssertEqual(sut.state, .loading)
        
        let expectation = self.expectation(description: "")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.3)
        XCTAssertEqual(sut.state, .loaded(characters[characterId]))
    }

    func testEventOnAppearError() {

        let error = NSError(domain: "", code: -1)
        charactersNetworkService.fetchCharactersResult = Fail(error: error).eraseToAnyPublisher()

        sut.sendEvent(event: .onAppear)
        XCTAssertEqual(sut.state, .loading)
        
        let expectation = self.expectation(description: "text expectation")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.3)
        
        XCTAssertEqual(sut.state, .error("The operation couldn’t be completed. ( error -1.)"))

    }
}
