//
//  CharactersNetworkService.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import Foundation

class CharactersNetworkService {
    
    var onCompletion: (([CharacterModel]) -> Void)?
    
    func fetchCharacters() {
        let URLString = "https://rickandmortyapi.com/api/character"
        performRequest(withURLString: URLString)
    }
    
    func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let sesseiom = URLSession(configuration: .default)
        let task = sesseiom.dataTask(with: url) { data, response, error in
            if let data = data {
                if let characters = self.parseJSON(withData: data) {
                    DispatchQueue.main.async {
                        self.onCompletion?(characters)
                    }
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> [CharacterModel]? {
        let decoder = JSONDecoder()
        do {
            let charactersModelData = try decoder.decode(CharactersModelData.self, from: data)
            var characters = [CharacterModel]()
            for characterData in charactersModelData.results {
                guard let character = CharacterModel(characterData: characterData) else {
                    return nil
                }
                characters.append(character)
            }
            return characters
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
