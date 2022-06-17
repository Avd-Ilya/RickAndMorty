//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.05.2022.
//

import CollectionAndTableViewCompatible
import Combine

class CharacterViewModel {
    
    public var showCharacterDetails: ((Int) -> Void)?
    
    private let charactersNetworkService: CharactersNetworkServiceProtocol
    var data: [TableViewCompatible] = []

    @Published var state = State.idle
    var cancellable: AnyCancellable?
    
    enum Event {
        case onAppear
        case onShowDetails(Int)
    }
    
    enum State: Equatable {
        case idle
        case loading
        case loaded
        case error(String)
    }
    
    init(charactersNetworkService: CharactersNetworkServiceProtocol = CharactersNetworkService()) {
        self.charactersNetworkService = charactersNetworkService
    }
    
    func fetchCharacters() {
        self.state = .loading
        self.cancellable = self.charactersNetworkService.fetchCharacters()
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

                let charactersCells = value.map({CharacterTableCellModel(character: $0)})
                self.data = charactersCells
                self.state = .loaded
            })
    }
    
    func sendEvent(event: Event) {
        switch event {
        case .onAppear:
            print("onAppear")
            fetchCharacters()
        case .onShowDetails(let characterId):
            print("onShowDetails")
            showCharacterDetails?(characterId)
        }
    }
}
