//
//  Pokemon.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct PokemonResponse: Codable{
    let list: PokemonList
}

struct PokemonList: Codable {
    let pokemons: [Pokemon]
}

struct Pokemon: Codable {
    let id: String
    let name: String
    let image: String
    let types: [PokemonType]
    let description: String?
    let stats: [Status]?
    
    var displayId: String {
        let idWithZeros = id.leftPadding(toLength: 3, withPad: "0")
        return "#\(idWithZeros)"
    }
    
    var capitalizedName: String {
        return name.capitalized
    }
    
    var descriptionText: String {
        return description?.replacingOccurrences(of: "\n", with: " ") ?? ""
    }
}

struct Status: Codable {
    let name: String
    let value: Int
}
