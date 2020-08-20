//
//  HomeDataEntity+CoreDataProperties.swift
//  Cavista
//
//  Created by Sanjay Mishra on 20/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

extension HomeDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HomeDataEntity> {
        return NSFetchRequest<HomeDataEntity>(entityName: "HomeDataEntity")
    }

    @NSManaged public var data: String?
    @NSManaged public var date: String?
    @NSManaged public var id: String?
    @NSManaged public var type: String?

}

extension HomeDataEntity {
    func convertToHomeDataModel() -> HomeDataModel {
        let jsonObj = JSON(self)
        let homeDataModelObj = HomeDataModel(fromJson: jsonObj)
        homeDataModelObj.type =  self.type
        homeDataModelObj.id = self.id
        homeDataModelObj.data = self.data
        homeDataModelObj.date = self.date
        return homeDataModelObj
    }
        
}
