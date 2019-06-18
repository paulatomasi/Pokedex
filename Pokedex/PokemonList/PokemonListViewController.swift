//
//  ViewController.swift
//  Pokedex
//
//  Created by Juliano Nardon on 07/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityController: UIView!
    
    private let presenter = PokemonListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configTable()
        self.presenter.view = self
        self.presenter.fetchData()
    }
    
    private func configTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = presenter
    }
}

extension PokemonListViewController: PokemonListViewType {
    func reloadData() {
        self.activityController.isHidden = true
        self.tableView.reloadData()
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = self.storyboard
        
        if let pokemonDetailViewController = storyboard?.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController {
            pokemonDetailViewController.pokemon = self.presenter.pokemon(at: indexPath.row)
            self.navigationController?.present(pokemonDetailViewController, animated: true)
        }
    }
 
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionType = presenter.swipeAction(for: indexPath.row)
        
        let contextualAction = UIContextualAction(style: .normal, title: actionType.text) { (action, view, handler) in
            self.presenter.swipe(at: indexPath.row)
            
            handler(true)
        }
        
        contextualAction.backgroundColor = actionType.color
        
        let configuration = UISwipeActionsConfiguration(actions: [contextualAction])
        
        return configuration
    }
    
}

enum PokemonSwipeAction {
    case addFavorite
    case removeFavorite
    
    var text: String {
        switch self {
        case .addFavorite:
            return "Favorite"
        case .removeFavorite:
            return "Remove"
        }
    }
    
    var color: UIColor {
        switch self {
        case .addFavorite:
            return UIColor(named: "grass")!
        case .removeFavorite:
            return UIColor(named: "fight")!
        }
    }
}

