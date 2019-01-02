//
//  HomeController.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 26/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
class HomeController:BaseController{
    static let Shared = HomeController()
    private override init(){}
    
    func fetchDogs( pageNum:String,completionHandler: @escaping( _ isSuccess:Bool,_ result:[CoreDataDog]?,_ error:String?) ->Void){
        NetworkClient.shared.getDogs(pageNum: pageNum){
            (isSuccess,response,error) in
            if(!isSuccess){
                completionHandler(false,nil,error)
            }else {
                if let result = response{
                    var DogArray:[CoreDataDog] = []
                    self.parseResponse(result, &DogArray)
                    completionHandler(true,DogArray,nil)
                }
            }
        }
    }
}
