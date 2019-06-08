//
//  Pokemon.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct PokemonList: Codable {
    let pokemons: [Pokemon]
}

struct Pokemon: Codable {
    let id: String
    let name: String
    let image: String
    let types: [PokemonType]
}

extension Pokemon: CustomStringConvertible {
    var description: String {
        return "\n\(self.name), com os tipos \(self.types)"
    }
}
