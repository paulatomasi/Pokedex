//
//  FavoriteListPresenter.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class FavoriteListPresenter: NSObject {
    
    weak var view: FavoriteListViewType?
    
    private lazy var interactor: FavoriteListInteractorInput = FavoriteListInteractor(output: self)
    
    var pokemonList = [Pokemon]()
}

extension FavoriteListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favorite", for: indexPath)
        
        if let pokemonCell = cell as? PokemonCollectionViewCell {
            pokemonCell.config(with: self.pokemonList[indexPath.item])
        }
        
        return cell
    }
}

extension FavoriteListPresenter: FavoriteListPresenterType {
    func fetchData() {
        self.interactor.fetchData()
    }
    
    func pokemon(at index: Int) -> Pokemon {
        return self.pokemonList[index]
    }
}

extension FavoriteListPresenter: FavoriteListInteractorOutput {
    func dataFetched(_ data: [Pokemon]) {
        self.pokemonList = data
        
        self.view?.reloadData()
    }
}
