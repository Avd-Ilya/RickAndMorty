//
//  CharactersNetworkServiceProtocols.swift
//  RickAndMorty
//
//  Created by Ilya on 16.06.2022.
//

import Combine

protocol CharactersNetworkServiceProtocol {
    func fetchCharacters() -> AnyPublisher<[CharacterModel], Error>
    func fetchCharacter(id: Int) -> AnyPublisher<[CharacterModel], Error>
}



