//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 28.05.2022.
//

import CollectionAndTableViewCompatible
import Combine
import RealmSwift

class CharacterViewModel {
    
    public var showCharacterDetails: ((Int) -> Void)?
    
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
        case updated
    }
    
    init(charactersNetworkService: CharactersNetworkServiceProtocol = CharactersNetworkService()) {
        self.charactersNetworkService = charactersNetworkService
    }
    
    func deleteAllLocalCharacters() {
        let value = localRealm.objects(CharacterModelRealm.self)

        for i in value {
            try! localRealm.write {
                localRealm.delete(i)
            }
        }
    }
    
    func fetchCharacters() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
                
        self.state = .loading
        fetchCharactersLocal()
        self.state = .loaded
        
        fetchCharactersWithNetwork()

        let count = localRealm.objects(CharacterModelRealm.self).count
        print("characters flom local DB - \(count)")
    }
    
    func fetchCharactersLocal() {
        let characters = localRealm.objects(CharacterModelRealm.self)
        var charactersModel = [CharacterModel]()

        for character in characters {
            if let characterModel = CharacterModel(charactersModelRealm: character) {
                charactersModel.append(characterModel)
            }
        }

        let charactersCells = charactersModel.map({CharacterTableCellModel(character: $0)})
        self.data = charactersCells
    }
    
    
    
    func fetchCharactersWithNetwork() {
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
                
                print("count characters from network - \(value.count)")
                
                self.writeToRealm(charactersModel: value)
                self.state = .updated
            })
    }
    
    func writeToRealm(charactersModel: [CharacterModel]) {
        var countСhangeable = 0
        
        do {
            try localRealm.write {
                let charactersModelFromLocal = localRealm.objects(CharacterModelRealm.self)
                
                for characterModel in charactersModel {
                    if charactersModelFromLocal.where({ $0.id == characterModel.id }).isEmpty {
                        let newCharacter = CharacterModelRealm(characterModel: characterModel)
                        localRealm.add(newCharacter)
                        countСhangeable += 1
                    }
                }
            }
        } catch let error {
            self.state = .error(error.localizedDescription)
        }
        
        print("count add characterl to local - \(countСhangeable)")
        fetchCharactersLocal()
    }
    
    func sendEvent(event: Event) {
        switch event {
        case .onAppear:
            print("onAppear")
            //deleteAllLocalCharacters()
            fetchCharacters()
        case .onShowDetails(let characterId):
            print("onShowDetails")
            showCharacterDetails?(characterId)
        }
    }
}
