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
    public var characterId: Int
    
    @Published var state = State.idle
    @Published var character = CharacterModel()
    var cancellable: AnyCancellable?

    enum Event {
        case onAppear
    }
    
    enum State: Equatable {
        case idle
        case loading
        case loaded
        case error(String)
    }
    
    init(characterId: Int) {
        self.characterId = characterId
    }
    
    func fetchCharacter(id: Int) {
        self.state = .loading
        self.cancellable = self.charactersNetworkService.fetchCharacter(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                    print(error)
                case .finished:
                    print("Success")
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                
                self.state = .loaded
                
                if let character = value.first {
                    self.character = character
                }
            })
    }
    
    func sendEvent(event: Event) {
        switch event {
        case .onAppear:
            print("onAppear")
            fetchCharacter(id: characterId)
        }
    }
    
}
