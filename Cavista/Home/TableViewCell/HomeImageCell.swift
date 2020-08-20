//
//  HomeTableCell.swift
//  Cavista
//
//  Created by Sanjay Mishra on 18/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class HomeImageCell: UITableViewCell {
    
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
            if let imageUrlString = dataViewModel?.data, let url = URL(string: imageUrlString) {
                productImage.sd_setImage(with: url, placeholderImage: nil, options: .lowPriority, context: nil)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
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
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Add views on cell
        addSubview(productImage)
        addSubview(idLabel)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
        
        productImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        idLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImage.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            //make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImage.snp.trailing).offset(10)
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
            //make.height.equalTo(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImage.snp.trailing).offset(10)
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
           // make.height.equalTo(20)
        }
        
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
