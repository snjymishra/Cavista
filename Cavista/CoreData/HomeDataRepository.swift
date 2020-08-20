//
//  HomeDataRepository.swift
//  Cavista
//
//  Created by Sanjay Mishra on 20/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//

import Foundation
import CoreData

protocol HomeDataRepositoryProtocol {
    func create(homeData: HomeDataModel, on context: NSManagedObjectContext)
    func getAll() -> [HomeDataModel]?
    func get(byIdentifier id: String) -> HomeDataModel?
}


struct HomeDataRepository : HomeDataRepositoryProtocol {
    
    //Save all data into core data
    func saveHomeDataEntity(listData: [HomeDataModel]?) {
        if let homeDataModelList = listData {

            //get main context
            let mainQueueContext = PersistentStorage.shared.context
            //Create private context
            let privateChildContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

            //make main context as a parent of child (private context)
            privateChildContext.parent = mainQueueContext

            //create data model on private context
            privateChildContext.performAndWait {
                for dataModel in homeDataModelList {
                    create(homeData: dataModel, on: privateChildContext)
                }
            }

            //merge changes to main context as well
            privateChildContext.performAndWait {
                try! privateChildContext.save()
            }

            //merge changes to persistence store as well
            PersistentStorage.shared.saveContext()
        }
    }

    //Create/update HomeDataEntity
    func create(homeData: HomeDataModel, on context: NSManagedObjectContext) {

        var homeDataEntity = getHomeDataEntity(byIdentifier: homeData.id)
        
        //Check if data is not present then create new object
        if homeDataEntity == nil {
            homeDataEntity = HomeDataEntity(context: context)
        }

        homeDataEntity?.id = homeData.id
        homeDataEntity?.type = homeData.type
        homeDataEntity?.date = homeData.date
        homeDataEntity?.data = homeData.data
    }

    //Get list of all save data
    func getAll() -> [HomeDataModel]? {

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: HomeDataEntity.self)

        var homeData : [HomeDataModel] = []
        
        result?.forEach({ (homeDataEntity) in
            homeData.append(homeDataEntity.convertToHomeDataModel())
        })
        return homeData
    }

    //Get one object by object identifier
    func get(byIdentifier id: String) -> HomeDataModel? {

        let result = getHomeDataEntity(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToHomeDataModel()
    }

    //Get object from coredata by data identifier if present otherwise return nil
    private func getHomeDataEntity(byIdentifier id: String) -> HomeDataEntity? {
        let fetchRequest: NSFetchRequest<HomeDataEntity> = HomeDataEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

            guard result != nil else {return nil}

            return result

        } catch let error {
            debugPrint(error)
        }

        return nil
    }
}
