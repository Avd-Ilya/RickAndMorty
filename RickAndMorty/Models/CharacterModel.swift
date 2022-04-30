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
}


