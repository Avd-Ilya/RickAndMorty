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
    var viewModel: CharacterViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CharacterViewModel()
        
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.delegate = self
        view.addSubview(myTableView)
            
        self.viewModel.fetchCharacters(tableView: myTableView)
    }
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailCharacterVC = DetailsCharactersViewController()
        
        let characterDetailViewModel = self.viewModel.getCharacterDetailViewModel(idCharacter: indexPath.row)

        detailCharacterVC.viewModel = characterDetailViewModel
        self.navigationController?.pushViewController(detailCharacterVC, animated: true)
    }
    
}

