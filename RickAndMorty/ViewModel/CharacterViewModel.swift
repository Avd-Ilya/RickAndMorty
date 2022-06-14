//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.05.2022.
//

import CollectionAndTableViewCompatible
import Combine

class CharacterViewModel {
    
    public var didSelectRow: ((Int) -> Void)?
    
    private let charactersNetworkService = CharactersNetworkService()
    var data: [TableViewCompatible] = []

    @Published var state = CharactersState.idle
    var cancellable: AnyCancellable?
    
    func fetchCharacters() {
        self.state = .Loading
        self.cancellable = self.charactersNetworkService.fetchCharacters()
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

                let charactersCells = value.map({CharacterTableCellModel(character: $0)})
                self.data = charactersCells
                
                if value.isEmpty {
                    self.state = .error
                } else {
                    self.state = .Loaded
                }
               
            })
    }
    
    func sendEvents(event: CharactersEvent, idCharacter: Int?) {
        switch event {
        case .onAppear:
            print("onAppear")
            fetchCharacters()
        case .onShowDetails:
            print("onShowDetails")
            guard let id = idCharacter else { return }
            self.didSelectRow?(id)
        }
    }
}
