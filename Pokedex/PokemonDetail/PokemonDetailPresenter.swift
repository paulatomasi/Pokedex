//
//  PokemonDetailPresenter.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 18/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonDetailPresenter: NSObject {
    weak var view: PokemonDetailViewType?
    
    lazy var interactor: PokemonDetailInteractorInput = PokemonDetailInteractor(output: self)
    
    private var pokemon: Pokemon?
}

extension PokemonDetailPresenter {
    func fetchData(pokemon: Pokemon) {
        self.interactor.fetchData(pokemon: pokemon)
    }
}

extension PokemonDetailPresenter: PokemonDetailInteractorOutput {
    func dataFetched(_ data: Pokemon) {
        self.pokemon = data
        
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
}
