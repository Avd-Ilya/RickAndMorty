//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Ilya on 16.06.2022.
//

import XCTest
import Combine
@testable import RickAndMorty


class CharacterViewModelTest: XCTestCase {

    var sut: CharacterViewModel!
    var charactersNetworkService: MockCharactersNetworkService!
    
    override func setUp() {
        super.setUp()
        charactersNetworkService = MockCharactersNetworkService()
        sut = .init(charactersNetworkService: charactersNetworkService)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testEventOnAppear() {
        
        let characters = [
            CharacterModel(id: 0, name: "testName", status: "testStatus", species: "testSpecies", gender: "testGender", location: "testLocation", image: "testImage", episode: ["1"])
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
        XCTAssertEqual(sut.state, .loaded)
        
        let characterCellModel = sut.data[0] as? CharacterTableCellModel
        XCTAssertEqual(characterCellModel?.name, characters[0].name)
        
    }
    
    func testEventOnAppearError() {

        let error = NSError(domain: "", code: -1)//NSError(domain: "error", code: -1, userInfo: nil)
        charactersNetworkService.fetchCharactersResult = Fail(error: error).eraseToAnyPublisher()

        sut.sendEvent(event: .onAppear)
        XCTAssertEqual(sut.state, .loading)
        
        let expectation = self.expectation(description: "")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.3)
        
        XCTAssertEqual(sut.state, .error("The operation couldn’t be completed. ( error -1.)"))

    }
    
    func testEventOnShowDetails() {
        let characterId = 0
        
        let characterFlowController = MockCharactersFlowController(viewModel: sut)
        characterFlowController.start()
        
        sut.sendEvent(event: .onShowDetails(characterId))
        XCTAssertTrue(characterFlowController.calledFlowController)
    }
}
