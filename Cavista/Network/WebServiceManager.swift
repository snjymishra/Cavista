//
//  WebServiceManager.swift
//  Cavista
//
//  Created by Sanjay Mishra on 19/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// Response
public struct NetworkManagerResponse {
    
    /// The server's response to the URL request.
    public let responseJSON: JSON?
    
    /// The error encountered while executing or validating the request.
    public let message: String?
    
    /// Status of the request.
    public let success: Bool?
    
    init(response: JSON?, status: Bool?, message: String?) {
        self.message = message
        self.responseJSON = response
        self.success = status
    }
}

class WebServiceManager {
    
    func getMethod(url: String, completion: @escaping (NetworkManagerResponse) -> Void) {
        
        AF.request(_: url ,method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler:{  response in
            switch response.result {
            case .success:
                let data = JSON(response.value as Any)
                completion(NetworkManagerResponse.init(response: data, status: true, message: ""))
            case .failure( _): break
            }
        })
    }
}
