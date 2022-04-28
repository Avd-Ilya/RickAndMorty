//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDelegate {
    
    var myTableView = UITableView()
    
    var characters = [CharacterModel]()
    let charactersNetworkService = CharactersNetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        myTableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reusedId)
        
        view.addSubview(myTableView)
        
        
        self.charactersNetworkService.fetchCharacters()
        charactersNetworkService.onCompletion = { /*[weak self]*/ characters in
            //guard let self = self else { return }
            self.characters = characters
            self.myTableView.reloadData()
            print(characters.count)
        }
    }
}


extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reusedId, for: indexPath) as! CharacterCell
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailCharacterVC = DetailsCharactersViewController()
        detailCharacterVC.characters.append(characters[indexPath.row])
        self.navigationController?.pushViewController(detailCharacterVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
