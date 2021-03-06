//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import Foundation

struct CharacterModel {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: String 
    let image: String
    let episode: [String]
    var numberOfEpisodeString: String {
        return "Number of episode - \(episode.count)"
    }

    init?(charactersModelRealm: CharacterModelRealm) {
        id = charactersModelRealm.id
        name = charactersModelRealm.name
        status = charactersModelRealm.status
        species = charactersModelRealm.species
        gender = charactersModelRealm.gender
        location = charactersModelRealm.location
        image = charactersModelRealm.image
        
        episode = charactersModelRealm.episode.map({$0})
    }
    
    init?(characterData: Result) {
        id = characterData.id ?? 0
        name = characterData.name ?? ""
        status = characterData.status ?? ""
        species = characterData.species ?? ""
        gender = characterData.gender ?? ""
        location = characterData.location?.name ?? ""
        image = characterData.image ?? ""
        episode = characterData.episode ?? [""]
    }
    
    init(id: Int, name: String, status: String, species: String, gender: String, location: String, image: String, episode: [String]) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.location = location
        self.image = image
        self.episode = episode
    }
    
    init() {
        id = 0
        name = ""
        status = ""
        species = ""
        gender = ""
        location = ""
        image = ""
        episode = [""]
    }
    
}


