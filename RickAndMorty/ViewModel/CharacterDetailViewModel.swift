//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.05.2022.
//

import Foundation
import Combine
import RealmSwift

class CharacterDetailViewModel {
    
    var localRealm: Realm {
        get {
            do {
                let realm = try Realm()
                return realm
            }
            catch let error{
                self.state = .error(error.localizedDescription)
            }
            return self.localRealm
        }
    }
    
    private let charactersNetworkService: CharactersNetworkServiceProtocol
    public var characterId: Int
    
    @Published var state = State.idle
    var cancellable: AnyCancellable?

    enum Event {
        case onAppear
    }
    
    enum State: Equatable {
        
        case idle
        case loading
        case loaded(CharacterModel)
        case error(String)
        
        static func == (lhs: CharacterDetailViewModel.State, rhs: CharacterDetailViewModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle):
                return true
            case (.loading, .loading):
                return true
            case (.loaded(let lhsCharacter), .loaded(let rhsCharacter)):
                return lhsCharacter.id == rhsCharacter.id
            case (.error(let lhsError), .error(let rhsError)):
                return lhsError == rhsError
            default:
                return false
            }
        }
    }
    
    init(characterId: Int, charactersNetworkService: CharactersNetworkServiceProtocol = CharactersNetworkService()) {
        self.characterId = characterId
        self.charactersNetworkService = charactersNetworkService
    }
    
    func fetchCharacter(id: Int) {
        do {
            try localRealm.write {
                let charactersModelFromLocal = localRealm.objects(CharacterModelRealm.self)
                
                if let characterModelRealm = charactersModelFromLocal.where({ $0.id == characterId }).first {
                    if let characterModel = CharacterModel(charactersModelRealm: characterModelRealm) {
                        self.state = .loaded(characterModel)
                    }
                }
            }
        } catch let error {
            self.state = .error(error.localizedDescription)
        }
    }
    
    func fetchCharacterWithNetwork(id: Int) {
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
                
                guard let character = value.first else { return }
                
                self.state = .loaded(character)
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
