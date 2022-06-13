//
//  AppFlowController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 09.06.2022.
//

import Foundation
import UIKit

final class AppFlowController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
    
    func start() {
        let charactersViewController = CharactersViewController()
        let charactersFlowController = CharactersFlowController(rootViewController: charactersViewController)
        
        add(childController: charactersFlowController)
        charactersFlowController.start()

    }
    
}
