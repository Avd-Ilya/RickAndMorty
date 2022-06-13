//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import UIKit
import CollectionAndTableViewCompatible
import Combine

class CharactersViewController: UIViewController {
    
    public var didFinish: (() -> Void)?
    public var didSelectRow: ((Int) -> Void)?
    
    var myTableView = UITableView()
    var viewModel: CharacterViewModel!
    private var cancellable = Set<AnyCancellable>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CharacterViewModel()
        
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.delegate = self
        view.addSubview(myTableView)
                    
        viewModel.$state
            .removeDuplicates()
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                
                switch value {
                case .onAppear:
                    print("onAppear")
                    self.viewModel.fetchCharacters(tableView: self.myTableView)
                case .onLoading:
                    print("Loading data")
                case .onLoaded:
                    print("Loaded data")
                case .error:
                    print("ERROR")
                }
            })
            .store(in: &cancellable)
    }
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRow?(indexPath.row)
    }
}

