//
//  HomeController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 26/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
class HomeController{
    static let Shared = HomeController()
    private init(){}
    fileprivate func parseResponse(_ result: [[String : AnyObject]], _ dogArray: inout [Dog]){
        for item in result{
            let dogObj = Dog()
            if let breeds = item[NetworkClient.Constants.ResponseKeys.Breeds] as? [[String:Any]],let id = item[NetworkClient.Constants.ResponseKeys.Id] as? String, let url = item[NetworkClient.Constants.ResponseKeys.Url] as? String{
                if !breeds.isEmpty{
                    let breed:Breed = Breed()
                    for breedItem in breeds{
                        breed.id = breedItem[NetworkClient.Constants.ResponseKeys.Id] as! Int
                        breed.name = breedItem[NetworkClient.Constants.ResponseKeys.Name] as! String
                        breed.lifeSpan = breedItem[NetworkClient.Constants.ResponseKeys.LifeSpan] as! String
                       // breed.breedGroup = breedItem[NetworkClient.Constants.ResponseKeys.BreedGroup] as! String
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
    func getMedicines( pageNum:String,completionHandler: @escaping( _ isSuccess:Bool,_ result:[Dog]?,_ error:String?) ->Void){
        NetworkClient.shared.getDogs(pageNum: pageNum){
            (isSuccess,response,error) in
            if(!isSuccess){
                completionHandler(false,nil,error)
            }else {
                if let result = response{
                    var DogArray:[Dog] = []
                    self.parseResponse(result, &DogArray)
                    completionHandler(true,DogArray,nil)
                }
            }
        }
    }
}
