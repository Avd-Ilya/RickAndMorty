//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.05.2022.
//

import UIKit
import Combine

class CharacterViewModel {
    
    private let charactersNetworkService = CharactersNetworkService()
    var data: CharacterTableViewDataSource!

    @Published var characters = [CharacterModel]()
    var cancellable: AnyCancellable?

    
    func fetchCharacters(tableView: UITableView) {
        self.cancellable = self.charactersNetworkService.fetchCharacters()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Success")
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.characters = value
                let charactersCells = value.map({CharacterTableCellModel(character: $0)})
                self.data = CharacterTableViewDataSource(characters: charactersCells, tableView: tableView)
            })
    }
    
    func getCharacterDetailViewModel(idCharacter: Int) -> CharacterDetailViewModel{
        let characterDetailViewModel = CharacterDetailViewModel()
        characterDetailViewModel.cancellable = self.$characters.sink(receiveValue: { value in
            characterDetailViewModel.character = value[idCharacter]
        })
        
        return characterDetailViewModel
    }
}
