//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Avdeev Ilya Aleksandrovich on 14.04.2022.
//

import UIKit
import CollectionAndTableViewCompatible
import Combine
import RealmSwift

class CharactersViewController: UIViewController {
    
    var myTableView = UITableView()
    var viewModel = CharacterViewModel()
    private var cancellable = Set<AnyCancellable>()
            
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CellIdentifier.CharacterCellIdentifier)
        view.addSubview(myTableView)
                    
        viewModel.sendEvent(event: .onAppear)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel.$state
            .removeDuplicates()
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.render(state: value)
            })
            .store(in: &cancellable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render(state: CharacterViewModel.State) {
        switch state {
        case .idle:
            print("idle")
        case .loading:
            print("Loading local data")
            let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: true)
        case .loaded:
            let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: false)
            self.myTableView.reloadData()
            print("Local data loaded")
        case .updated:
            self.myTableView.reloadData()
            print("Data loaded From Network")
        case .error(let description):
            let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: false)
            print("ERROR - \(description)")
        }
    }

}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let characterCellModel = viewModel.data[indexPath.row] as? CharacterTableCellModel {
            viewModel.sendEvent(event: .onShowDetails(characterCellModel.id))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.viewModel.data[indexPath.row].cellForTableView(tableView: self.myTableView, atIndexPath: indexPath)
        return cell
    }
    
}


