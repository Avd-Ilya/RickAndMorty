//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.05.2022.
//

import UIKit

class CharacterViewModel {
    
    private let charactersNetworkService = CharactersNetworkService()
    var data: CharacterTableViewDataSource!

    var characters = [CharacterModel]()
    
    func fetchCharacters(tableView: UITableView) {
        charactersNetworkService.fetchCharacters()
        charactersNetworkService.onCompletion = { [weak self] characters in
            
            self?.characters = characters

            let charactersCells = characters.map({CharacterTableCellModel(character: $0)})
            self!.data = CharacterTableViewDataSource(characters: charactersCells, tableView: tableView)
        }
    } 
}
