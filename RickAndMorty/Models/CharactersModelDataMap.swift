//
//  CharactersModelDataMap.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 29.04.2022.
//

import Foundation
import ObjectMapper

// MARK: - Welcome
struct CharactersModelDataMap: Mappable {

    var results: [Result]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        results <- map["results"]
    }
    
}


// MARK: - Result
struct Result: Mappable {

    var id: Int?
    var name: String?
    var status: String? //Status
    var species: String? //Species
    var gender: String? //Gender
    var location: Location?
    var image: String?
    var episode: [String]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        status <- map["status"]
        species <- map["species"]
        gender <- map["gender"]
        location <- map["location"]
        image <- map["image"]
        episode <- map["episode"]
    }
}

// MARK: - Location
struct Location: Mappable {
    
    var name: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
    }
    
}
