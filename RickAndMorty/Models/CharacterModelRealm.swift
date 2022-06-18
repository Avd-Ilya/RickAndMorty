//
//  CharacterModelRealm.swift
//  RickAndMorty
//
//  Created by Ilya on 17.06.2022.
//

import RealmSwift

class CharacterModelRealm: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var status: String
    @Persisted var species: String
    @Persisted var gender: String
    @Persisted var location: String
    @Persisted var image: String
    @Persisted var episode: List<String>
    
    init(characterModel: CharacterModel) {
        id = characterModel.id
        name = characterModel.name
        status = characterModel.status
        species = characterModel.species
        gender = characterModel.gender
        location = characterModel.location
        image = characterModel.image
        
        let episodes = List<String>()
        for episode in characterModel.episode {
            episodes.append(episode)
        }
        episode = episodes
    }
    
    override init() {
        id = 0
        name = ""
        status = ""
        species = ""
        gender = ""
        location = ""
        image = ""
        episode = List<String>()
    }
}

