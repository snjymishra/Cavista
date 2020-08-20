//
//  HomeModel.swift
//  Cavista
//
//  Created by Sanjay Mishra on 19/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//

import Foundation
 
// MARK: - HomeDataModel


import SwiftyJSON

class HomeDataModel{

    var data : String!
    var date : String!
    var id : String!
    var type : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = json["data"].stringValue
        date = json["date"].stringValue
        id = json["id"].stringValue
        type = json["type"].stringValue
    }

}
