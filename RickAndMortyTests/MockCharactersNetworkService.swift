//
//  MockCharactersNetworkService.swift
//  RickAndMortyTests
//
//  Created by Ilya on 16.06.2022.
//

import Combine
@testable import RickAndMorty

class MockCharactersNetworkService: CharactersNetworkServiceProtocol  {
    
    var fetchCharactersResult: AnyPublisher<[CharacterModel], Error>?
    
    func fetchCharacters() -> AnyPublisher<[CharacterModel], Error> {
        if let results = fetchCharactersResult {
            return results
        } else {
            fatalError()
        }
    }
    
    func fetchCharacter(id: Int) -> AnyPublisher<[CharacterModel], Error> {
        if let results = fetchCharactersResult {
            return results
        } else {
            fatalError()
        }
    }
    
    
}

