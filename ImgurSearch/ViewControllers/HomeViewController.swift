//
//  HomeViewController.swift
//  ImgurSearch
//
//  Created by Jake Gray on 11/23/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Objects
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Imgur Search"
        label.font = UIFont.systemFont(ofSize: 54, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let searchbar: UISearchBar = {
        let bar = UISearchBar()
        bar.sizeToFit()
        bar.backgroundColor = .clear
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        bar.placeholder = "Search for an image"
        return bar
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = mainGray
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        searchbar.delegate = self
        
        setNeedsStatusBarAppearanceUpdate()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        NetworkController.shared.imageCache.removeAllObjects()
    }
    
    //MARK:- Private Methods
    
    private func setupViews() {
        view.addSubview(searchbar)
        view.addSubview(titleLabel)
        view.addSubview(searchButton)
        
        searchbar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        searchbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        searchbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        searchbar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: searchbar.topAnchor, constant: -8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: searchbar.bottomAnchor, constant: 8).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    //MARK:- Actions
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func searchButtonPressed() {
        
        dismissKeyboard()
        
        if let searchTerm = searchbar.text {
            let searchTableVC = SearchViewController()
            searchTableVC.searchTerm = searchTerm
            navigationController?.pushViewController(searchTableVC, animated: true)
        }
    }

}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonPressed()
    }
}
