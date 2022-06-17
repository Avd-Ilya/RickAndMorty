//
//  CharacterCellModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.04.2022.
//

import Foundation
import CollectionAndTableViewCompatible

class CharacterTableCellModel: TableViewCompatible {
    
    var reuseIdentifier: String {
        return CellIdentifier.CharacterCellIdentifier
    }
    
    var selected: Bool = false
    
    let id: Int
    let name: String
    let species: String
    let gender: String
    let image: String
    
    init(id: Int, name: String, species: String, gender: String, image: String) {
        self.id = id
        self.name = name
        self.species = species
        self.gender = gender
        self.image = image
    }
    
    convenience init(character: CharacterModel) {
        self.init(id: character.id, name: character.name, species: character.species, gender: character.gender, image: character.image)
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CharacterTableViewCell
        
        cell.configure(withModel: self)
        return cell
    }
}

