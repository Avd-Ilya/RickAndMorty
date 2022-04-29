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
    
    var data: MyTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.delegate = self
        view.addSubview(myTableView)
    
        self.myTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CellIdentifier.CharacterCellIdentifier)
        
        self.charactersNetworkService.fetchCharacters()
        charactersNetworkService.onCompletion = { /*[weak self]*/ characters in
            
            self.data = MyTableViewDataSource(characters: characters, tableView: self.myTableView)
            self.data.prepareData()
            self.characters = characters
            self.myTableView.reloadData()
        
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

