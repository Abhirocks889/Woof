//
//  BaseController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 28/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import UIKit

class BaseController{
    func parseResponse(_ result: [[String : AnyObject]], _ dogArray: inout [Dog]){
        for dog in result{
            parseDogItem(dog, &dogArray)
        }
    }
    
    func parseDogItem(_ dog: [String : AnyObject], _ dogArray: inout [Dog]) {
        let dogObj = Dog()
        if let breeds = dog[NetworkClient.Constants.ResponseKeys.Breeds] as? [[String:Any]],let id = dog[NetworkClient.Constants.ResponseKeys.Id] as? String, let url = dog[NetworkClient.Constants.ResponseKeys.Url] as? String{
            if !breeds.isEmpty{
                let breed:Breed = Breed()
                for breedItem in breeds{
                    breed.id = breedItem[NetworkClient.Constants.ResponseKeys.Id] as! Int
                    breed.name = breedItem[NetworkClient.Constants.ResponseKeys.Name] as! String
                    breed.lifeSpan = breedItem[NetworkClient.Constants.ResponseKeys.LifeSpan] as! String
                    if let group = breedItem[NetworkClient.Constants.ResponseKeys.BreedGroup] as? String{
                        breed.breedGroup = group
                    }
                    if let bredFor = breedItem[NetworkClient.Constants.ResponseKeys.BredFor] as? String{
                        breed.bredFor = bredFor
                    }
                    if let temperment = breedItem[NetworkClient.Constants.ResponseKeys.Tempermant] as? String{
                        breed.temperament = temperment
                    }
                    if let weight = breedItem[NetworkClient.Constants.ResponseKeys.Weight] as? [String:Any]{
                        let wt = Weight()
                        wt.imperial = weight[NetworkClient.Constants.ResponseKeys.Imperial] as! String
                        wt.metric = weight[NetworkClient.Constants.ResponseKeys.Metric]  as! String
                        breed.weight = wt
                    }
                    if let height = breedItem[NetworkClient.Constants.ResponseKeys.Height] as? [String:Any]{
                        let ht = Height()
                        ht.imperial = height[NetworkClient.Constants.ResponseKeys.Imperial] as! String
                        ht.metric = height[NetworkClient.Constants.ResponseKeys.Metric]  as! String
                        breed.height = ht
                    }
                    dogObj.breed.append(breed)
                    dogObj.id = id
                    dogObj.url = url
                }
            }
            dogArray.append(dogObj)
        }
    }
}
