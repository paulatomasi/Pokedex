//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonListPresenter: NSObject {
    weak var view: PokemonListViewType?
    
    private lazy var interactor: PokemonListInteractorInput = PokemonListInteractor(output: self)
    
    private var pokemonList = [Pokemon]()
    
    private let idsKey = "favorite.ids"
    
    override init() {
        super.init()
        
        if let data = UserDefaults.standard.array(forKey: idsKey) as? [String] {
            self.favoriteIds = Set(data)
        }
    }
    
    private var favoriteIds: Set<String> = [] {
        didSet {
            UserDefaults.standard.set(Array(favoriteIds), forKey: idsKey)
        }
    }
}

extension PokemonListPresenter {
    func fetchData() {
        self.interactor.fetchData()
    }
    
    func pokemon(at index: Int) -> Pokemon {
        return self.pokemonList[index]
    }
    
    func swipe(at index: Int) {
        let pokemonId = pokemon(at: index).id
        
        if self.favoriteIds.contains(pokemonId) {
            self.favoriteIds.remove(pokemonId)
        } else {
            self.favoriteIds.insert(pokemonId)
        }
    }
    
    func swipeAction(for index: Int) -> PokemonSwipeAction {
        return self.favoriteIds.contains(pokemon(at: index).id) ? .removeFavorite : .addFavorite
    }
}

extension PokemonListPresenter: PokemonListInteractorOutput {
    func dataFetched(_ data: PokemonList) {
        self.pokemonList = data.pokemons
        self.view?.reloadData()
    }
}

extension PokemonListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath)
        
        if let pokemonCell = cell as? PokemonTableViewCell {
            pokemonCell.config(with: self.pokemonList[indexPath.row])
        }
        
        return cell
    }
}
