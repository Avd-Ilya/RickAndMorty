//
//  UIViewControllerExtensions.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 09.06.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func add(childController: UIViewController){
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    
    func remove(childController: UIViewController){
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
}
