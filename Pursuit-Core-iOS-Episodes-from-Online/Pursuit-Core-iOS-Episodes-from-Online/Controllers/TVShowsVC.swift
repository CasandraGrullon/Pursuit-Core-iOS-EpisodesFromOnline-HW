//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class TVShowsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [Show](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet{
            loadData(with: searchQuery)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func loadData(with search: String){
        TVShowAPI.getShows(for: search) { (result) in
            switch result{
            case .failure(let appError):
                print(appError)
            case .success(let data):
                self.shows = data
            }
        }
        
    }

    
}

extension TVShowsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? TVShowCell else {
            fatalError("cell error")
        }
        let tvshow = shows[indexPath.row]
        
        cell.configureCell(for: tvshow)
        
        return cell
    }
}
extension TVShowsVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
        TVShowAPI.getShows(for: searchQuery) { (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let show):
                self.shows = show
                
            }
        }

    }
}
