//
//  CurrentCharactersData.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import Foundation

// MARK: - Welcome
struct CharactersModelData: Codable {
    let results: [Result]
}


// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let status: String //Status
    let species: String //Species
    let gender: String //Gender
    let location: Location
    let image: String
    let episode: [String]
}

// MARK: - Location
struct Location: Codable {
    let name: String
}
