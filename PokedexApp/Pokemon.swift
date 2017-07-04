//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Shayan Zahid on 28/06/2017.
//  Copyright © 2017 Shayan Zahid. All rights reserved.
//

import Foundation

class Pokemon
{
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    var name: String
    {
        return _name
    }
    
    var pokedexID: Int
    {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int)
    {
        self._name = name
        self._pokedexID  = pokedexID
    }
}
