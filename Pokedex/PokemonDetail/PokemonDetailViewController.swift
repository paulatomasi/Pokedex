//
//  pokemonDetailViewController.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit
import Nuke

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewCenterVerticallyConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewTopVerticallyConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonDetailViewFinalPositionConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonDetailViewInitialPositionConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonTypesStackView: NSLayoutConstraint!
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var primaryPokemonTypeView: PokemonTypeView!
    @IBOutlet weak var secondPokemonTypeView: PokemonTypeView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonDescriptionLabel: UILabel!
    @IBOutlet weak var pokemonStatsLabel: UILabel!
    
    private let presenter = PokemonDetailPresenter()
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "detailView"
        
        self.presenter.view = self
        self.initialConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.requestPokemon()
        self.loadPokemonAnimation()
    }
    
    func loadPokemonAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.pokemonImageView.alpha = 0.2
        })
    }
    
    func requestPokemon() {
        if let pokemon = self.pokemon {
            self.presenter.fetchData(pokemon: pokemon)
        }
    }
    
    func animatePokemonToTop() {
        DispatchQueue.main.async {
            self.pokemonImageView.layer.removeAllAnimations()
            
            self.pokemonImageViewWidthConstraint.constant = 100
            self.pokemonImageViewHeightConstraint.constant = 100
            
            self.pokemonImageViewCenterVerticallyConstraint.priority = UILayoutPriority(rawValue: 900)
            self.pokemonImageViewTopVerticallyConstraint.priority = UILayoutPriority(rawValue: 999)
            
            self.pokemonDetailViewInitialPositionConstraint.priority = UILayoutPriority(rawValue: 900)
            self.pokemonDetailViewFinalPositionConstraint.priority = UILayoutPriority(rawValue: 999)

            UIView.animate(withDuration: 1, animations: {
                self.pokemonImageView.alpha = 1
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func initialConfig() {
        if let pokemon = self.pokemon {
            self.pokemonImageView.loadImage(from: pokemon.image)
            
            if let primaryType = pokemon.types.first {
                let pokemonColor = primaryType.color
                
                self.gradientView.startColor = pokemonColor ?? .black
                self.gradientView.endColor = pokemonColor?.lighter() ?? .white
                
                self.primaryPokemonTypeView.config(type: primaryType, asMiniType: false)
            }
            
            if pokemon.types.count > 1{
                let secondType = pokemon.types[1]
                
                self.secondPokemonTypeView.config(type: secondType, asMiniType: false)
            } else {
                self.secondPokemonTypeView.isHidden = true
                self.pokemonTypesStackView.constant = 95
            }
            
            self.pokemonNameLabel.text = pokemon.capitalizedName
            self.pokemonStatsLabel.textColor = pokemon.types.first?.color
        }
    }
    
    func loadDetails() {
        DispatchQueue.main.async {
            if let pokemon = self.pokemon {
                self.pokemonDescriptionLabel.text = pokemon.descriptionText
            }
        }
    }
}

extension PokemonDetailViewController: PokemonDetailViewType {
    func reloadData() {
        self.loadDetails()
        self.animatePokemonToTop()
    }
}
