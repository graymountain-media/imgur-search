//
//  SearchTableViewController.swift
//  ImgurSearch
//
//  Created by Jake Gray on 11/20/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK:- Properties
    
    var searchTerm: String?
    var pageNumber: Int = 0 {
        didSet {
            print("Page number changed to: \(pageNumber)")
        }
    }
    var didReachBottom = false
    
    var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
            didReachBottom = false
        }
    }
    
    let cellId: String = "SearchCell"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Objects
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = mainGray
        view.separatorStyle = .none
        return view
    }()
    
    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.barStyle = .black
        controller.searchBar.tintColor = .white
        return controller
    }()
    
    let searchbar: UISearchBar = {
        let bar = UISearchBar()
        bar.barStyle = .default
        return bar
    }()
    
    lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissSearchbar))

    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = mainGray
        
        navigationController?.navigationBar.prefersLargeTitles = false
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem?.tintColor = .white

        setupSearchbar()
        setupTableView()
        
        if let searchText = searchTerm {
            searchbar.text = searchText
            getFirstPage()
        }
    }
    
    //MARK:- Private Methods
    private func setupSearchbar() {
        
        navigationItem.titleView = searchbar
        searchbar.delegate = self

    }
    
    @objc private func dismissSearchbar() {
        searchbar.endEditing(true)
        view.removeGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupTableView() {
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func getFirstPage() {
        pageNumber = 1
        print("Page number \(pageNumber)")
        NetworkController.shared.imageCache.removeAllObjects()
        searchbar.endEditing(true)
        if let searchTerm = searchbar.text, !searchTerm.isEmpty {
            
            NetworkController.shared.fetchPosts(withSearchTerm: searchTerm, onPage: 1) { (posts) in
                if let newPosts = posts {
                    self.posts = newPosts
                }
            }
            
        }
    }
    
    private func getPage(number: Int) {
        NetworkController.shared.imageCache.removeAllObjects()
        searchbar.endEditing(true)
        if let searchTerm = searchbar.text, !searchTerm.isEmpty {
            
            NetworkController.shared.fetchPosts(withSearchTerm: searchTerm, onPage: number) { (posts) in
                if let newPosts = posts {
                    self.posts += newPosts
                }
            }
            
        }
    }
    
    private func checkForEmptyResult() {
        if posts.count <= 0 {
            let alert = UIAlertController(title: "No Images Found", message: "Please try another search", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ImageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.updateCellWith(title: posts[indexPath.row].title, image: UIImage())
        
        if let images = posts[indexPath.row].images {
            if let url = URL(string: images[0].link){
            cell.customImageView.af_setImage(withURL: url)
            }
        } else {
            if let url = URL(string: posts[indexPath.row].link!) {
                cell.customImageView.af_setImage(withURL: url)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell tapped")
        guard let cell = tableView.cellForRow(at: indexPath) as? ImageTableViewCell else {
            print("ERROR: Cannot get tapped cell")
            return
        }
        let imageToPass = cell.customImageView.image
        let titleToPass = cell.titleLabel.text
        
        let detailVC = DetailViewController()
        detailVC.image = imageToPass
        detailVC.imageTitle = titleToPass
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if didReachBottom == false {
                didReachBottom = true
                pageNumber += 1
                print("Getting new page: \(pageNumber)")
                getPage(number: pageNumber)
            }
            
        }
    }

}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getFirstPage()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.text = ""
        searchbar.endEditing(true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
}
