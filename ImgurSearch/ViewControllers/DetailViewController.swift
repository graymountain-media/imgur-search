//
//  DetailViewController.swift
//  ImgurSearch
//
//  Created by Jake Gray on 11/23/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK:- Properties
    
    var image: UIImage?
    var imageTitle: String?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Objects
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainGray
        
        navigationItem.titleView = titleLabel
        
        if let image = image, let imageTitle = imageTitle {
            imageView.image = image
            titleLabel.text = imageTitle
        }
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }

}
