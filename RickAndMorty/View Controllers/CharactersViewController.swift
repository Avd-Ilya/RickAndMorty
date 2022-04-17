//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var characters = [CharacterModel]()
    let charactersNetworkService = CharactersNetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersNetworkService.fetchCharacters()
        charactersNetworkService.onCompletion = { /*[weak self]*/ characters in
            //guard let self = self else { return }
            self.characters = characters
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailCharacterVC = segue.destination as! DetailsCharactersViewController
                detailCharacterVC.characters.append(characters[indexPath.row])
            }
        }
    }
}


extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterCell
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
}
