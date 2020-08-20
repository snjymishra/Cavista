//
//  DetailViewModel.swift
//  Cavista
//
//  Created by Sanjay Mishra on 20/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//

import Foundation

struct DetailViewModel {
    private let homeData: HomeDataModel

    init(_ homeData: HomeDataModel) {
        self.homeData = homeData
    }
}


extension DetailViewModel {
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
