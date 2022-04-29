//
//  DetailCharactersViewController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 15.04.2022.
//

import UIKit

class DetailsCharactersViewController: UIViewController {
    
    var characters = [CharacterModel]()
    
    let baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    let speciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label
    }()
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.sizeToFit()
        return imageView
    }()
    
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
                guard let data = data else {return}
                self.characterImageView.image = UIImage(data: data)
            }
        }
        
        view.addSubview(baseView)
        baseView.addSubview(nameLabel)
        baseView.addSubview(characterImageView)
        baseView.addSubview(speciesLabel)
        baseView.addSubview(genderLabel)
        baseView.addSubview(statusLabel)
        baseView.addSubview(locationLabel)
        baseView.addSubview(numberLabel)
        
        addConstraints()
    }
    
    func addConstraints() {
        baseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        baseView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        baseView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 15).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
        
        characterImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        characterImageView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor).isActive = true

        speciesLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 10).isActive = true
        speciesLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        speciesLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true

        genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 10).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        genderLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true

        statusLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true

        locationLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true

        numberLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
    }
}
