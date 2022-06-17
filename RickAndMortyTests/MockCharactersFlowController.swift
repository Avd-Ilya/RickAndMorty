//
//  MockCharactersFlowController.swift
//  RickAndMortyTests
//
//  Created by Ilya on 17.06.2022.
//

import UIKit
@testable import RickAndMorty

class MockCharactersFlowController {
     
    var viewModel = CharacterViewModel()
    var calledFlowController = false
    
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
    }
    
    public func start() {
        viewModel.showCharacterDetails = { [weak self] id in
            guard let self = self else { return }
            self.calledFlowController = true
        }
    }

}
