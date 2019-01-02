//
//  BreedsController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 27/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation

class BreedsController:BaseController{
    static let Shared = BreedsController()
    private override init(){}
    
    func getDogByBreed(breedId:Int,completionHandler: @escaping( _ isSuccess:Bool,_ result:CoreDataDog?,_ error:String?) ->Void )  {
        NetworkClient.shared.getDogByBreed(breedId:breedId){
            (isSuccess,response,errorMessage) in
            if(isSuccess){
                if let response = response ,!response.isEmpty{
                    var dogArray:[CoreDataDog] = []
                    self.parseResponse(response,&dogArray)
                    completionHandler(true,dogArray[0],nil)
                }else{
                    completionHandler(false,nil,"It's not you,it's us ☹️.Something went wrong!!")
                }
            }else{
                completionHandler(false,nil,errorMessage)
            }
        }
    }
    func getBreeds(completionHandler: @escaping( _ isSuccess:Bool,_ result:[CoreDataBreeds]?,_ error:String?) ->Void){
        NetworkClient.shared.getBreeds{
            (isSuccess,response,error) in
            if(!isSuccess){
                completionHandler(false,nil,error)
            }else {
                if let result = response{
                    var breedsArray:[CoreDataBreeds] = []
                    self.parseResponse(result, &breedsArray)
                    completionHandler(true,breedsArray,nil)
                }
            }
        }
    }
    
    fileprivate func parseResponse(_ result: [[String : AnyObject]], _ dogArray: inout [CoreDataBreeds]){
        for item in result{
            guard let id = item[NetworkClient.Constants.ResponseKeys.Id] as? Int else{
                fatalError("Response doesn't contain id")
            }
            guard let name = item[NetworkClient.Constants.ResponseKeys.Name] as? String else{
                fatalError("Response doesnt contain name")
            }
            let breeds = CoreDataBreeds(id: id, name: name, context: DataController.shared.viewContext)
            DataController.shared.saveContext()
            dogArray.append(breeds)
        }
    }
}
