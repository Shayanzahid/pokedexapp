//
//  PokemonDetailVC.swift
//  PokedexApp
//
//  Created by Shayan Zahid on 03/07/2017.
//  Copyright © 2017 Shayan Zahid. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name.capitalized
    }
}
