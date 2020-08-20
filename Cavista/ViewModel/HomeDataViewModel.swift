//
//  HomeDataViewModel.swift
//  Cavista
//
//  Created by Sanjay Mishra on 19/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//

import Foundation
import Alamofire

struct Constants {
    static let HomeDataSourceURL = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
}


class HomeDataListViewModel {
    private var homeListViewModel: [HomeDataModel]?
    private let serviceManager = WebServiceManager()

    func getData(completionHandler: @escaping (_ isSuccess: Bool) -> Void) {
        
        if NetworkReachabilityManager.default?.isReachable ?? false {
            //Load live data from server
            getDatafromServer { (success) in
                completionHandler(success)
            }
        } else {
            //Load local saved data
            loadSavedData { (success) in
                completionHandler(success)
            }
        }
    }
    
    private func getDatafromServer(completionHandler: @escaping (_ isSuccess: Bool) -> Void) {
        serviceManager.getMethod(url: Constants.HomeDataSourceURL) { [weak self]  (response) in
            if let listData = response.responseJSON?.array {
                var homeModelObj = [HomeDataModel]()
                for item in listData {
                    homeModelObj.append(HomeDataModel.init(fromJson: item))
                }
                self?.saveDataIntoCoreData(data: homeModelObj)
                self?.homeListViewModel = homeModelObj
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }
    }

    private func saveDataIntoCoreData(data: [HomeDataModel]?) {
        if let dataModelList = data {
            let backgroundQueue = DispatchQueue.global(qos: .background)
            backgroundQueue.async {
                HomeDataRepository().saveHomeDataEntity(listData: dataModelList)
            }
        }
    }

    private func loadSavedData(completionHandler: @escaping (_ isSuccess: Bool) -> Void) {
        if let listData = HomeDataRepository().getAll() {
            self.homeListViewModel = listData
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }
}


extension HomeDataListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.homeListViewModel?.count ?? 0
    }
    
    func homeListDataAtIndex(_ index: Int) -> HomeDataViewModel? {
        if index >= self.homeListViewModel?.count ?? 0 {
            return nil
        }

        guard let homeData = self.homeListViewModel?[index] else {
            return nil
        }
        return HomeDataViewModel(homeData)
    }
    
    func homeDataModelAtIndex(_ index: Int) -> HomeDataModel? {
        if index >= self.homeListViewModel?.count ?? 0 {
            return nil
        }

        guard let homeData = self.homeListViewModel?[index] else {
            return nil
        }
        return homeData
    }
}


struct HomeDataViewModel {
    private let homeData: HomeDataModel

    init(_ homeData: HomeDataModel) {
        self.homeData = homeData
    }
}


extension HomeDataViewModel {
    var id: String {
        return self.homeData.id
    }
    
    var type: String {
        return self.homeData.type
    }
    
    var date: String? {
        return self.homeData.date
    }
    
    var data: String? {
        return self.homeData.data
    }
}

