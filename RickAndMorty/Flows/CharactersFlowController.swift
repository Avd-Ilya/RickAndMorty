//
//  CharactersFlowController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 09.06.2022.
//

import Foundation
import UIKit

class CharactersFlowController: UINavigationController {
    
    public var didFinish: ((UIViewController) -> Void)?
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    public func start() {
        guard let charactersController = self.viewControllers.first as? CharactersViewController else { return }
                
        charactersController.viewModel.showCharacterDetails = { [weak self] id in
            guard let self = self else { return }
            self.showDetails(characterId: id)
        }
    }
    
    func showDetails(characterId: Int) {
        let viewModel = CharacterDetailViewModel(characterId: characterId)
        let detailsCharacterVC = DetailsCharactersViewController(viewModel: viewModel)
        pushViewController(detailsCharacterVC, animated: true)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
