//
//  NetworkClient.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 25/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkClient {
    static let shared = NetworkClient()
    private init() {}
    
    func getDogByBreed(breedId:Int,comletionHandler : @escaping (_ _success:Bool , _ response:[[String:AnyObject]]? , _ errorMessage:String?) -> Void){
        let params = [Constants.ParameterKeys.BreedId:breedId] as [String:AnyObject]
        let url = getUrlFromParameters(params, pathExtension:Constants.DogCeo.apiPathExtension)
        handleGetCallForJsonArrayObje(url,comletionHandler)
    }
    func getBreeds(completionHandler : @escaping( _ success:Bool , _ response:[[String:AnyObject]]?, _ errormessage:String?) -> Void) {
        let params = [Constants.ParameterKeys.Page:Constants.ParameterValues.ValuePageDefault,
        Constants.ParameterKeys.Limit:Constants.ParameterValues.ValueBreedsLimitDefault] as [String:AnyObject]
        let url = getUrlFromParameters(params , pathExtension: Constants.DogCeo.apiPathExtensionBreeds)
        handleGetCallForJsonArrayObje(url, completionHandler)
    }
    
    func getDogs(pageNum:String,completionHandler : @escaping(_ success:Bool ,_ response:[[String:AnyObject]]?,_ errorMessage:String?) -> Void){
        let params = [Constants.ParameterKeys.Page : pageNum,
                      Constants.ParameterKeys.Size : Constants.ParameterValues.ValueSize,
                      Constants.ParameterKeys.MimeTypes :Constants.ParameterValues.ValueMimeType,
                      Constants.ParameterKeys.Format:Constants.ParameterValues.ValueFormat,
                      Constants.ParameterKeys.HasBreeds:Constants.ParameterValues.ValueHasBreeds,
                      Constants.ParameterKeys.Limit:Constants.ParameterValues.ValueLimitDefault] as [String : AnyObject]
        
        let url = getUrlFromParameters(params , pathExtension: Constants.DogCeo.apiPathExtension)
        handleGetCallForJsonArrayObje(url, completionHandler)
    }
    
    fileprivate func handleGetCallForJsonArrayObje(_ url: URL, _ completionHandler: @escaping (Bool, [[String : AnyObject]]?, String?) -> Void) {
        // get a session manager and add the request adapter
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = CustomRequestAdapter()
        let request = sessionManager.request(url, method: .get, parameters: nil, encoding:JSONEncoding.default)
        request.responseJSON{ responseData in
            switch responseData.result{
            case .success :
                if let response = responseData.result.value{
                    let json = JSON(response)
                    print(json.arrayObject as? [[String:AnyObject]] ?? "No value")
                    completionHandler(true,json.arrayObject as? [[String:AnyObject]],nil)
                }else{
                    completionHandler(false,nil,"Something went wrong!Please try again")
                }
            case .failure(let error):
                completionHandler(false,nil,error.localizedDescription)
            }
        }
    }
    private  func getUrlFromParameters (_ parameters: [String:AnyObject],pathExtension:String = "") -> URL{
        var components = URLComponents()
        let withPathExtension = pathExtension
        components.scheme = Constants.DogCeo.apiScheme
        components.host =  Constants.DogCeo.apiHost
        components.path = Constants.DogCeo.apiPath + (withPathExtension )
        
        components.queryItems = [URLQueryItem]()
        for (key , value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems?.append(queryItem)
        }
        return components.url!
    }
}
