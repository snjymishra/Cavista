//
//  HomeViewController.swift
//  Cavista
//
//  Created by Sanjay Mishra on 18/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let tableView = UITableView()
    private let homeTableCellIdentifier = "HomeImageCell"
    private let homeTextCellIdentifier = "HomeTextCell"
    private let homeDataListViewModel = HomeDataListViewModel()
    
    override func loadView() {
        super.loadView()
        //Setup navigation view
        setUpNavigation()
           
        //setup table view
        setupTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
           
        //Register tableview cells
        tableView.register(HomeImageCell.self, forCellReuseIdentifier: homeTableCellIdentifier)
        tableView.register(HomeTextCell.self, forCellReuseIdentifier: homeTextCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
    }
    
    func setUpNavigation() {
        navigationItem.title = "Home List"
        
    }
    //Add tableview on view and set constraints
    func setupTableView() {
        view.addSubview(tableView)

        // Add tableview constraints
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //Get data from server
    private func getData(){
        homeDataListViewModel.getData { [weak self] (success) in
            if success {
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.homeDataListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellData = self.homeDataListViewModel.homeListDataAtIndex(indexPath.row)
        
        if cellData?.type == "image"{
            let cell = tableView.dequeueReusableCell(withIdentifier: homeTableCellIdentifier) as! HomeImageCell
            cell.dataViewModel = cellData
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: homeTextCellIdentifier) as? HomeTextCell else {
                fatalError("cell not found")
            }
            cell.selectionStyle = .none
            cell.dataViewModel = cellData
            return cell
        }
        
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        if let data = self.homeDataListViewModel.homeDataModelAtIndex(indexPath.row) {
            detailVC.detailDataViewModel = DetailViewModel(data)
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
}

