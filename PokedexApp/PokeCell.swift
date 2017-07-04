//
//  PokeCell.swift
//  PokedexApp
//
//  Created by Shayan Zahid on 29/06/2017.
//  Copyright © 2017 Shayan Zahid. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell
{
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var thumbLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(_ pokemon: Pokemon)
    {
        self.pokemon = pokemon
        
        thumbImage.image = UIImage(named: String(self.pokemon.pokedexID))
        thumbLabel.text = self.pokemon.name.capitalized
        
        self.layer.cornerRadius = 20.0
        self.clipsToBounds = true
    }
}
