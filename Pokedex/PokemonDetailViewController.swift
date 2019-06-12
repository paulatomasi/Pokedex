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
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var pokemonImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewCenterVerticallyConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewTopVerticallyConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pokemonTypeView: PokemonTypeView!
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialConfig()
        
        if let type = self.pokemon?.types.first {
            self.pokemonTypeView.config(type: type)
        }
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
            let requestMaker = RequestMaker()
            requestMaker.make(withEndpoint: .details(query: pokemon.id)) {
                (pokemon: Pokemon) in
                self.pokemon = pokemon
                self.animatePokemonToTop()
            }
        }
    }
    
    func animatePokemonToTop() {
        DispatchQueue.main.async {
            self.pokemonImageView.layer.removeAllAnimations()
            
            self.pokemonImageViewWidthConstraint.constant = 80
            self.pokemonImageViewHeightConstraint.constant = 80
        
            self.pokemonImageViewCenterVerticallyConstraint.priority = UILayoutPriority(rawValue: 900)
            self.pokemonImageViewTopVerticallyConstraint.priority = UILayoutPriority(rawValue: 999)
            
            UIView.animate(withDuration: 1, animations: {
                self.pokemonImageView.alpha = 1
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func initialConfig() {
        if let pokemon = self.pokemon {
            let pokemonColor = pokemon.types.first?.color
            
            self.gradientView.startColor = pokemonColor ?? .black
            self.gradientView.endColor = pokemonColor?.lighter() ?? .white
            
            self.pokemonImageView.loadImage(from: pokemon.image)
        }
    }
}
