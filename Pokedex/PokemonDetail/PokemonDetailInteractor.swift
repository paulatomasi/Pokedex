//
//  PokemonDetailInteractor.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 18/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class PokemonDetailInteractor {
    
    private let requestMaker = RequestMaker()
    private weak var output: PokemonDetailInteractorOutput?
    
    init(output: PokemonDetailInteractorOutput) {
        self.output = output
    }
}

extension PokemonDetailInteractor: PokemonDetailInteractorInput {
    func fetchData(pokemon: Pokemon) {
        requestMaker.make(withEndpoint: .details(query: pokemon.id)) { (pokemon: Pokemon) in
            self.output?.dataFetched(pokemon)
        }
    }
}
