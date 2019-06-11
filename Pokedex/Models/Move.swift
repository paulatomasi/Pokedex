//
//  Move.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 09/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct Move: Codable {
    let name: String
    let learnLevel: Int
    let type: PokemonType
}

extension Move: CustomStringConvertible {
    var displayName: String {
        let formattedName = name.replacingOccurrences(of: "-", with: " ")
        
        return formattedName.capitalized
    }
    
    var description: String {
        return "\(displayName): level \(learnLevel) | type \(type)"
    }
}
