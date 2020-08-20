//
//  DetailViewController.swift
//  Cavista
//
//  Created by Sanjay Mishra on 20/08/20.
//  Copyright © 2020 Sanjay Mishra. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailDataViewModel: DetailViewModel? {
          didSet {
              if let id = detailDataViewModel?.id {
                  idLabel.text = "Id: " + id
              } else {
                  idLabel.text = ""
              }
              
              if let date = detailDataViewModel?.date {
                  dateLabel.text = "Date: " + date
              } else {
                  dateLabel.text = ""
              }

              if detailDataViewModel?.type == "image" {
                  if let imageUrlString = detailDataViewModel?.data, let url = URL(string: imageUrlString) {
                      imageView.sd_setImage(with: url, placeholderImage: nil, options: .lowPriority, context: nil)
                  }
              } else {
                  descriptionLabel.text = detailDataViewModel?.data
              }
          }
      }

    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let idLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()

    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        label.sizeToFit()
        
        return label
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()

    override func loadView() {
        super.loadView()
        //Set up UI
        setupView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(imageView)
        self.scrollView.addSubview(idLabel)
        self.scrollView.addSubview(dateLabel)
        self.scrollView.addSubview(descriptionLabel)

        //Set constraints
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(10)
            
        }

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(self.view.frame.size.width)
           if detailDataViewModel?.type == "image" {
               make.height.equalTo(200)
           } else {
               make.height.equalTo(0)
           }
        }

        idLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }

        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(idLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(self.view.frame.size.width - 20)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.bottom.equalTo(scrollView.snp.bottom).offset(10)
            
        }
   }
    
}
