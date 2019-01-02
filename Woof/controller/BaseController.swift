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
    func parseResponse(_ result: [[String : AnyObject]], _ dogArray: inout [CoreDataDog]){
        for dog in result{
            parseDogItem(dog, &dogArray)
        }
    }
    
    func parseDogItem(_ dog: [String : AnyObject], _ dogArray: inout [CoreDataDog]) {
        let dogObj:CoreDataDog
        if let breeds = dog[NetworkClient.Constants.ResponseKeys.Breeds] as? [[String:Any]],let id = dog[NetworkClient.Constants.ResponseKeys.Id] as? String, let url = dog[NetworkClient.Constants.ResponseKeys.Url] as? String{
            if !breeds.isEmpty{
                for breedItem in breeds{
                    let breedId = breedItem[NetworkClient.Constants.ResponseKeys.Id] as! Int
                    let name = breedItem[NetworkClient.Constants.ResponseKeys.Name] as! String
                    let lifeSpan = breedItem[NetworkClient.Constants.ResponseKeys.LifeSpan] as! String
                    var dogGroup = ""
                    if let group = breedItem[NetworkClient.Constants.ResponseKeys.BreedGroup] as? String{
                        dogGroup = group
                    }
                    var dogBredFor = ""
                    if let bredFor = breedItem[NetworkClient.Constants.ResponseKeys.BredFor] as? String{
                       dogBredFor = bredFor
                    }
                    var dogTempermant = ""
                    if let temperment = breedItem[NetworkClient.Constants.ResponseKeys.Tempermant] as? String{
                        dogTempermant = temperment
                    }
                    var weightImperial = ""
                    var weightMetric  = ""
                    if let weight = breedItem[NetworkClient.Constants.ResponseKeys.Weight] as? [String:Any]{
                         weightImperial = weight[NetworkClient.Constants.ResponseKeys.Imperial] as! String
                         weightMetric = weight[NetworkClient.Constants.ResponseKeys.Metric]  as! String
                    }
                    var heightImperial = ""
                    var heightMetric = ""
                    if let height = breedItem[NetworkClient.Constants.ResponseKeys.Height] as? [String:Any]{
                    heightImperial = height[NetworkClient.Constants.ResponseKeys.Imperial] as! String
                       heightMetric = height[NetworkClient.Constants.ResponseKeys.Metric]  as! String
                    }
                    let wieghtStored = CoreDataWeight(imperial: weightImperial, metric: weightMetric, context: DataController.shared.viewContext)
                    DataController.shared.saveContext()
                    let heightStored = CoreDataHeight(imperial: heightImperial, metric: heightMetric, context: DataController.shared.viewContext)
                    DataController.shared.saveContext()
                    let breedStored = CoreDataBreed(bredFor: dogBredFor, breedGroup:dogGroup, id: breedId, lifeSpan: lifeSpan, name: name, tempermant: dogTempermant, height: heightStored, weight: wieghtStored, context: DataController.shared.viewContext)
                   let dogId = id
                   let dogUrl = url
                    if let url = URL(string: dogUrl), let data = try? Data(contentsOf: url){
                        dogObj = CoreDataDog(id: dogId, imageData: data, url: dogUrl, breed: breedStored, context: DataController.shared.viewContext)
                        DataController.shared.saveContext()
                        dogArray.append(dogObj)
                        break
                    }
                }
            }
        }
    }
}
