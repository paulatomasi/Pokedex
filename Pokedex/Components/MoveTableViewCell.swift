//
//  MoveTableViewCell.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 09/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonTipeView: PokemonTypeView!
    
    func config(with model: Move) {
        self.nameLabel.text = model.displayName

        self.pokemonTipeView.config(type: model.type, asMiniType: true)
    }
}

