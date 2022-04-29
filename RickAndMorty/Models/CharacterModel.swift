//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String //Status
    let species: String //Species
    let gender: String //Gender
    let location: String //Location
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


