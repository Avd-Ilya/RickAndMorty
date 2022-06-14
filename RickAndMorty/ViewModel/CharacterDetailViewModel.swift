//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.05.2022.
//

import Foundation
import Combine

class CharacterDetailViewModel {
    
    private let charactersNetworkService = CharactersNetworkService()

    @Published var state = DetailsCharacterState.idle
    @Published var character = CharacterModel()
    var cancellable: AnyCancellable?

    func fetchCharacter(id: Int) {
        self.state = .Loading
        self.cancellable = self.charactersNetworkService.fetchCharacter(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.state = .error
                    print(error)
                case .finished:
                    print("Success")
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                
                if let character = value.first {
                    self.character = character
                }
                
                if value.isEmpty {
                    self.state = .error
                } else {
                    self.state = .Loaded
                }
               
            })
    }
    
    func sendEvent(evetn: DetailsCharacterEvent) {
        switch evetn {
        case .onAppear:
            print("onAppear")
        }
    }
    
}
