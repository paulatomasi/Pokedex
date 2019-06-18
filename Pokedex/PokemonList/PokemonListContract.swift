//
//  PokemonListContract.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

protocol PokemonListViewType: AnyObject {
    func reloadData()
}

protocol PokemonListPresenterType: UITableViewDataSource {
    var view: PokemonListViewType? { get set }
    func fetchData()
    func pokemon(at index: Int) -> Pokemon
}

protocol PokemonListInteractorInput {
    func fetchData()
}

protocol PokemonListInteractorOutput: AnyObject {
    func dataFetched(_ data: PokemonList)
}
