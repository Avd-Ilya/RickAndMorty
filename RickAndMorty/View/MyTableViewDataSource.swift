//
//  MyTableViewDataSource.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.04.2022.
//

import Foundation
import CollectionAndTableViewCompatible

enum Sections: Int {
    case CharacterSection
}

class MyTableViewDataSource: TableViewDataSource {
    let characters: [CharacterModel]
    
    init(characters: [CharacterModel], tableView: UITableView) {
        self.characters = characters
        super.init(tableView: tableView)
    }
    
    func prepareData() {
        
        var items = [TableViewCompatible]()
        
        for character in self.characters {
            let characterCellModel = CharacterCellModel(character: character)
            items.append(characterCellModel)
        }
        
        let section = TableViewSection(sortOrder: Sections.CharacterSection.rawValue, items: items, headerTitle: nil, footerTitle: nil)
        
        sections = [section]
    }
    

    
}
