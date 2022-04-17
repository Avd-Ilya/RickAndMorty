//
//  DetailCharactersViewController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 15.04.2022.
//

import UIKit

class DetailsCharactersViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var characters = [CharacterModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let character = characters.first else { return }
        
        self.nameLabel.text = character.name
        self.speciesLabel.text = character.species
        self.genderLabel.text = character.gender
        self.statusLabel.text = character.status
        self.locationLabel.text = character.location
        self.numberLabel.text = character.numberOfEpisodeString

        let url = URL(string: character.image)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }
    }
}
