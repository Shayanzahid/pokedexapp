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
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonBioLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonDefenseLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonBaseAttackLabel: UILabel!
    @IBOutlet weak var pokemonEvoLabel: UILabel!
    @IBOutlet weak var pokemonCurrImage: UIImageView!
    @IBOutlet weak var pokemonEvoImage: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateLocalData()
        
        pokemon.downloadPokemonDetail
        {
            //THIS IS A CLOSURE AND WILL WORK ONLY WHEN NETWORK CALL IS COMPLETED
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        pokemonDefenseLabel.text = String(pokemon.defense)
        pokemonHeightLabel.text = String(pokemon.height)
        pokemonWeightLabel.text = String(pokemon.weight)
        pokemonBaseAttackLabel.text = String(pokemon.baseAttack)
        pokemonTypeLabel.text = pokemon.type
        pokemonBioLabel.text = pokemon.description
        
        if pokemon.nextEvolutionID == -1
        {
            pokemonEvoLabel.text = "No Evolutions Available"
            pokemonEvoImage.isHidden = true
        } else
        {
            pokemonEvoImage.image = UIImage(named: String(pokemon.nextEvolutionID))
            let newPokemonEvoLabel = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            pokemonEvoLabel.text = newPokemonEvoLabel
        }
    }
    
    func updateLocalData()
    {
        let image = UIImage(named: String(pokemon.pokedexID))
        
        nameLabel.text = pokemon.name.capitalized
        pokemonImage.image = image
        pokemonCurrImage.image = image
        pokemonIDLabel.text = String(pokemon.pokedexID)
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}
