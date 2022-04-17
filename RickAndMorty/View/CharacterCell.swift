//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 15.04.2022.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var imageCharacterView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    func configure(with character: CharacterModel) {
        let url = URL(string: character.image)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.imageCharacterView.image = UIImage(data: data!)
            }
        }
        
        self.nameLabel.text = character.name
        self.speciesLabel.text = character.species
        self.genderLabel.text = character.gender
    }
}
