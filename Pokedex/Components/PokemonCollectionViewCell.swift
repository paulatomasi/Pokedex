//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonStatsLabel: UILabel!
    @IBOutlet weak var pokemonStatsValueLabel: UILabel!
    
    @IBOutlet weak var pokemonPrimaryTypeView: PokemonTypeView!
    @IBOutlet weak var pokemonSecondaryTypeView: PokemonTypeView!
    
    func config(with model: Pokemon) {
        let mainColor = model.mainType?.color ?? .black	
        gradientView.startColor = mainColor
        gradientView.endColor = mainColor.lighter() ?? .white
        
        pokemonImageView.loadImage(from: model.image)
        pokemonNameLabel.text = model.capitalizedName
        
        pokemonPrimaryTypeView.config(type: model.types.first!, asMiniType: true)
        
        if model.types.count > 1 {
            pokemonSecondaryTypeView.isHidden = false
            pokemonSecondaryTypeView.config(type: model.types[1], asMiniType: true)
        } else {
            pokemonSecondaryTypeView.isHidden = true
        }
    }
}
