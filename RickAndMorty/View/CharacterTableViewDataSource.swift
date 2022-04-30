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

class CharacterTableViewDataSource: TableViewDataSource {
    
    var data: [TableViewCompatible] {
        didSet {
            prepareData()
            tableView.reloadData()
        }
    }
    
    init(characters: [CharacterTableCellModel], tableView: UITableView) {
        self.data = characters
        super.init(tableView: tableView)
        defer { self.data = characters }
        registerTableViewCell()
    }
    
    func registerTableViewCell() {
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CellIdentifier.CharacterCellIdentifier)
    }
    
    func prepareData() {

        let section = TableViewSection(sortOrder: Sections.CharacterSection.rawValue, items: data, headerTitle: nil, footerTitle: nil)
        
        sections = [section]
    }
}
