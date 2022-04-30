//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.04.2022.
//

import Foundation
import CollectionAndTableViewCompatible

class CharacterTableViewCell: UITableViewCell, Configurable {
    
    var model: CharacterTableCellModel?
    
    let baseView = UIView()
    let characterImageView = UIImageView()
    let nameLabel = UILabel()
    let speciesLabel = UILabel()
    let genderLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(baseView)
        baseView.addSubview(characterImageView)
        baseView.addSubview(nameLabel)
        baseView.addSubview(speciesLabel)
        baseView.addSubview(genderLabel)
        
        setupUI()
        addConstraints()
    }
    
    func configure(withModel model: CharacterTableCellModel) {
        self.model = model
        
        let url = URL(string: model.image)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                guard let data = data else {return}
                self.characterImageView.image = UIImage(data: data)
            }
        }
        
        self.nameLabel.text = model.name
        self.speciesLabel.text = model.species
        self.genderLabel.text = model.gender
        
    }
    
    func setupUI() {
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        nameLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.font = UIFont.systemFont(ofSize: 17)
        speciesLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.font = UIFont.systemFont(ofSize: 17)
        genderLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    func addConstraints() {

        self.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
