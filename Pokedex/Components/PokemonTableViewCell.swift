//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var primaryPokemonTypeView: PokemonTypeView!
    @IBOutlet weak var secondaryPokemonTypeView: PokemonTypeView!
    
    func config(with model: Pokemon) {
        pictureImageView.loadImage(from: model.image)
        nameLabel.text = model.capitalizedName
        idLabel.text = model.displayId

        primaryPokemonTypeView.config(type: model.types.first!, asMiniType: true)
        
        if model.types.count > 1 {
            secondaryPokemonTypeView.isHidden = false
            secondaryPokemonTypeView.config(type: model.types[1], asMiniType: true)
        } else {
            secondaryPokemonTypeView.isHidden = true
        }
    }
}
