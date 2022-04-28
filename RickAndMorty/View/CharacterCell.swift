//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 15.04.2022.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    static let reusedId = "CharacterCell"
    
    let baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    let speciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(baseView)
        baseView.addSubview(characterImageView)
        baseView.addSubview(nameLabel)
        baseView.addSubview(speciesLabel)
        baseView.addSubview(genderLabel)
                
        //baseView constraints
        baseView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        baseView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        baseView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        baseView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        //characterImageView constraints
        characterImageView.topAnchor.constraint(equalTo: baseView.topAnchor).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor).isActive = true
        characterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //nameLabel constraints
        nameLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        //speciesLabel constraints
        speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        speciesLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20).isActive = true
        speciesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        speciesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //genderLabel constraints
        genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 5).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20).isActive = true
        genderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        genderLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func configure(with character: CharacterModel){
        let url = URL(string: character.image)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                guard let image = UIImage(data: data!) else {return}
                self.characterImageView.image = image
            }
        }
        
        self.nameLabel.text = character.name
        self.speciesLabel.text = character.species
        self.genderLabel.text = character.gender
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


