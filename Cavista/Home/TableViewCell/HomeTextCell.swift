//
//  HomeTextCell.swift
//  Cavista
//
//  Created by Sanjay Mishra on 19/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//

import UIKit
import SnapKit

class HomeTextCell: UITableViewCell {

    var dataViewModel: HomeDataViewModel? {
          didSet {
              if let id = dataViewModel?.id {
                  idLabel.text = "Id: " + id
              } else {
                  idLabel.text = ""
              }
              
              if let date = dataViewModel?.date {
                  dateLabel.text = "Date: " + date
              } else {
                  dateLabel.text = ""
              }

              descriptionLabel.text = dataViewModel?.data
          }
      }
      
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          
          //Add views on cell
          addSubview(idLabel)
          addSubview(dateLabel)
          addSubview(descriptionLabel)
          
          idLabel.snp.makeConstraints { make in
              make.leading.equalToSuperview().offset(10)
              make.trailing.equalToSuperview().offset(-10)
              make.top.equalToSuperview().offset(10)
          }
          
          dateLabel.snp.makeConstraints { make in
              make.leading.equalToSuperview().offset(10)
              make.trailing.equalToSuperview().offset(-10)
              make.top.equalTo(idLabel.snp.bottom).offset(5)
          }
          
          descriptionLabel.snp.makeConstraints { make in
              make.leading.equalToSuperview().offset(10)
              make.trailing.equalToSuperview().offset(-10)
              make.top.equalTo(dateLabel.snp.bottom).offset(10)
              make.bottom.equalToSuperview().offset(-10)
          }
          
          self.backgroundColor = .clear
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      private let idLabel : UILabel = {
          let label = UILabel()
          label.backgroundColor = .clear
          label.textColor = .black
          label.textAlignment = .left
          label.numberOfLines = 1
          label.font = .systemFont(ofSize: 15.0)
          return label
      }()
      
      private let dateLabel : UILabel = {
          let label = UILabel()
          label.backgroundColor = .clear
          label.textColor = .black
          label.textAlignment = .left
          label.numberOfLines = 1
          label.font = .systemFont(ofSize: 15.0)
          return label
      }()
      
      private let descriptionLabel : UILabel = {
          let label = UILabel()
          label.backgroundColor = .clear
          label.textColor = .black
          label.textAlignment = .left
          label.font = .systemFont(ofSize: 13.0)
          label.numberOfLines = 0
          label.lineBreakMode = .byWordWrapping
          label.clipsToBounds = true
          
          return label
      }()
      
      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          
          // Configure the view for the selected state
      }
      
}
