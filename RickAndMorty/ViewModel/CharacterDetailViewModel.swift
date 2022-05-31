//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.05.2022.
//

import Foundation
import Combine

class CharacterDetailViewModel {

    @Published var character = CharacterModel()
    var cancellable: AnyCancellable?

}
