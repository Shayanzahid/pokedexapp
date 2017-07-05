//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Shayan Zahid on 28/06/2017.
//  Copyright © 2017 Shayan Zahid. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: Int!
    private var _height: Int!
    private var _weight: Int!
    private var _baseAttack: Int!
    private var _nextEvolutionText: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: Int!
    private var _nextEvolutionLevel: Int!
    private var _pokemonURL: String!
    
    var name: String
    {
        if _name == nil
        {
            self._name = ""
        }
        return _name
    }
    
    var pokedexID: Int
    {
        if _pokedexID == nil
        {
            self._pokedexID = -1
        }
        return _pokedexID
    }
    
    var description: String
    {
        if _description == nil
        {
            self._description = ""
        }
        return _description
    }
    
    var type: String
    {
        if _type == nil
        {
            self._type = ""
        }
        return _type
    }
    
    var defense: Int
    {
        if _defense == nil
        {
            self._defense = -1
        }
        return _defense
    }
    
    var height: Int
    {
        if _height == nil
        {
            self._height = -1
        }
        return _height
    }
    
    var weight: Int
    {
        if _weight == nil
        {
            self._weight = -1
        }
        return _weight
    }
    
    var baseAttack: Int
    {
        if _baseAttack == nil
        {
            self._baseAttack = -1
        }
        return _baseAttack
    }
    
    var nextEvolutionText: String
    {
        if _nextEvolutionText == nil
        {
            self._nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionName: String
    {
        if _nextEvolutionName == nil
        {
            self._nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionID: Int
    {
        if _nextEvolutionID == nil
        {
            self._nextEvolutionID = -1
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionLevel: Int
    {
        if _nextEvolutionLevel == nil
        {
            self._nextEvolutionLevel = -1
        }
        return _nextEvolutionLevel
    }
    
    var pokemonURL: String
    {
        if _pokemonURL == nil
        {
            self._pokemonURL = ""
        }
        return _pokemonURL
    }
    
    init(name: String, pokedexID: Int)
    {
        self._name = name
        self._pokedexID  = pokedexID
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self.pokedexID)"
    }
    
    func downloadPokemonDetail(completed: @escaping DOWNLOAD_COMPLETE)
    {
        Alamofire.request(pokemonURL).responseJSON
        { (response) in
           if let dict = response.result.value as? Dictionary<String, AnyObject>
            {
                if let weight = dict["weight"] as? String
                {
                    self._weight = Int(weight)
                }
                
                if let height = dict["height"] as? String
                {
                    self._height = Int(height)
                }
                
                if let baseAttack = dict["attack"] as? Int
                {
                    self._baseAttack = baseAttack
                }
                
                if let defense = dict["defense"] as? Int
                {
                    self._defense = defense
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0
                {
                    if let name = types[0]["name"]
                    {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1
                    {
                        for index in 1..<types.count
                        {
                            if let name = types[index]["name"]
                            {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }
                
                if let descriptionArr = dict["descriptions"] as? [Dictionary<String, String>] , descriptionArr.count > 0
                {
                    if let URL = descriptionArr[0]["resource_uri"]
                    {
                        let descriptionURL = "\(BASE_URL)\(URL)"
                        Alamofire.request(descriptionURL).responseJSON(completionHandler:
                        { (response) in
                            if let descriptionDict = response.result.value as? Dictionary<String, AnyObject>
                            {
                                if let pokemonDescription = descriptionDict["description"] as? String
                                {
                                    self._description = pokemonDescription
                                }
                            }
                            completed()
                        })
                    }
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0
                {
                    if let nextEvolution = evolutions[0]["to"] as? String
                    {
                        if nextEvolution.range(of: "mega") == nil
                        {
                            self._nextEvolutionName = nextEvolution
                            
                            if let URI = evolutions[0]["resource_uri"] as? String
                            {
                                let NEW_URI = URI.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolutionID = NEW_URI.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionID = Int(nextEvolutionID)
                                
                                if let levelExists = evolutions[0]["level"]
                                {
                                    if let level = levelExists as? Int
                                    {
                                        self._nextEvolutionLevel = level
                                    }
                                } else
                                {
                                    self._nextEvolutionLevel = -1
                                }
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}
