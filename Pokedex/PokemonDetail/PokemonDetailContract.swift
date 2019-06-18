//
//  PokemonDetailContract.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

protocol PokemonDetailViewType: AnyObject {
    func reloadData()
}

protocol PokemonDetailPresenterType: UITableViewDataSource {
    var view: PokemonDetailViewType? { get set }
    func fetchData(pokemon: Pokemon)
}

protocol PokemonDetailInteractorInput {
    func fetchData(pokemon: Pokemon)
}

protocol PokemonDetailInteractorOutput: AnyObject {
    func dataFetched(_ data: Pokemon)
}

