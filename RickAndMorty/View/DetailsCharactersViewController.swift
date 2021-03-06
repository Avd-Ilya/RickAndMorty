//
//  DetailCharactersViewController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 15.04.2022.
//

import UIKit
import Combine

class DetailsCharactersViewController: UIViewController {
        
    var viewModel: CharacterDetailViewModel
    private var cancellable = Set<AnyCancellable>()
    
    let baseView = UIView()
    let nameLabel = UILabel()
    let speciesLabel = UILabel()
    let genderLabel = UILabel()
    let statusLabel = UILabel()
    let locationLabel = UILabel()
    let numberLabel = UILabel()
    let characterImageView = UIImageView()
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.sendEvent(event: .onAppear)
        addUI()
        
        viewModel.$state
            .removeDuplicates()
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                
                self.render(state: value)
            })
            .store(in: &cancellable)
    }
    
    private func render(state: CharacterDetailViewModel.State) {
        switch state {
        case .idle:
            print("idle")
        case .loading:
            let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: true)
            print("Loading data")
        case .loaded(let character):
            let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: false)
            self.binding(character: character)
            print("Data loaded")
        case .error(let description):
            let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: false)
            print("ERROR - \(description)")
        }
    }
    
    func addUI() {
        view.addSubview(baseView)
        baseView.addSubview(nameLabel)
        baseView.addSubview(characterImageView)
        baseView.addSubview(speciesLabel)
        baseView.addSubview(genderLabel)
        baseView.addSubview(statusLabel)
        baseView.addSubview(locationLabel)
        baseView.addSubview(numberLabel)
        
        setupUI()
        addConstraints()
    }
    
    func binding(character: CharacterModel) {
        
        self.nameLabel.text = character.name
        self.speciesLabel.text = character.species
        self.genderLabel.text = character.gender
        self.statusLabel.text = character.status
        self.locationLabel.text = character.location
        self.numberLabel.text = character.numberOfEpisodeString

        if let url = URL(string: character.image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    guard let data = data else {return}
                    self.characterImageView.image = UIImage(data: data)
                }
            }
        }
        
    }
    
    func setupUI() {
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.font = UIFont.systemFont(ofSize: 25)
        speciesLabel.textAlignment = .center
        speciesLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.font = UIFont.systemFont(ofSize: 25)
        genderLabel.textAlignment = .center
        genderLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont.systemFont(ofSize: 25)
        statusLabel.textAlignment = .center
        statusLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.systemFont(ofSize: 25)
        locationLabel.textAlignment = .center
        locationLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = UIFont.systemFont(ofSize: 25)
        numberLabel.textAlignment = .center
        numberLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        characterImageView.sizeToFit()
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
