//
//  CharactersNetworkService.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import Foundation
import Combine

class CharactersNetworkService: CharactersNetworkServiceProtocol {
    
    var onCompletion: (([CharacterModel]) -> Void)?
    
    func fetchCharacters() -> AnyPublisher<[CharacterModel], Error> {

        let urlString = "https://rickandmortyapi.com/api/character"
               
        guard let url = URL(string: urlString) else { return Fail(error: NSError(domain: "", code: -1, userInfo: nil))
            .eraseToAnyPublisher()}
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map {$0.data}
            .compactMap { data -> [CharacterModel] in
                if let characters = self.parseJSON(withData: data) {
                    return characters
                } else {
                    return [CharacterModel]()
                }
            }
            .catch({_ in
                Just([])
            })
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        return publisher
    }
    
    func fetchCharacter(id: Int) -> AnyPublisher<[CharacterModel], Error> {

        let urlString = "https://rickandmortyapi.com/api/character/\(id)"
               
        guard let url = URL(string: urlString) else { fatalError("invalid URL") }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map {$0.data}
            .compactMap { data -> [CharacterModel] in
                if let character = self.characterParseJSON(withData: data) {
                    return [character]
                } else {
                    return [CharacterModel]()
                }
            }
            .catch({_ in
                Just([])
            })
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        return publisher
    }
    
    func parseJSON(withData data: Data) -> [CharacterModel]? {

        let str = String(decoding: data, as: UTF8.self)
        
        let charactersModelData = CharactersModelDataMap(JSONString: str)
        var characters = [CharacterModel]()
        guard let charactersModels = charactersModelData?.results else {return nil}
        for characterData in charactersModels {
            guard let character = CharacterModel(characterData: characterData) else {
                return nil
            }
            characters.append(character)
        }
        return characters
    }
    
    func characterParseJSON(withData data: Data) -> CharacterModel? {

        let str = String(decoding: data, as: UTF8.self)

        let charactersModelData = Result(JSONString: str)
        
        guard let characterModel = charactersModelData else {return nil}

        let character = CharacterModel(characterData: characterModel)
        return character
    }
}
