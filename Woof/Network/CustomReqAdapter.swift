//
//  CustomReqAdapter.swift
//  Woof
//
//  Created by Rajeev Ranganathan on 26/12/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

class CustomRequestAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if let sessionId = getSessionId() {
            var request =  urlRequest
            request.setValue(sessionId, forHTTPHeaderField:NetworkClient.Constants.Header.Authorization)
            return request
        }else{
            fatalError("Failed to get SessionId")
        }
    }
    
    private func getSessionId() -> String? {
        if let path = Bundle.main.path(forResource: "DogCeo-Info", ofType:"plist"),let dict = NSDictionary(contentsOfFile: path){
            return dict["APIKey"] as? String
        }
        return nil
    }
}
