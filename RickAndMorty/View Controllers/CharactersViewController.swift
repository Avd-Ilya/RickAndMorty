//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import UIKit
import CollectionAndTableViewCompatible

class CharactersViewController: UIViewController {
    
    var myTableView = UITableView()
    
    var characters = [CharacterModel]()
    let charactersNetworkService = CharactersNetworkService()
    
    var data: CharacterTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.delegate = self
        view.addSubview(myTableView)
            
        self.charactersNetworkService.fetchCharacters()
        charactersNetworkService.onCompletion = { /*[weak self]*/ characters in
            
            self.characters = characters
            
            let charactersCells = characters.map({CharacterTableCellModel(character: $0)})
            self.data = CharacterTableViewDataSource(characters: charactersCells, tableView: self.myTableView)
        }
    }
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailCharacterVC = DetailsCharactersViewController()
        detailCharacterVC.characters.append(characters[indexPath.row])
        self.navigationController?.pushViewController(detailCharacterVC, animated: true)
    }
    
}

