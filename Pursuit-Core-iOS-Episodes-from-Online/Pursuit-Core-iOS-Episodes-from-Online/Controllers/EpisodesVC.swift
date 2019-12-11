//
//  EpisodesVC.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tvShow: Show?
    
    var episodes = [Episode](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEpisodes()
        tableView.dataSource = self
    }

    func loadEpisodes(){
        EpisodeAPIClient.getEpisodes(for: tvShow?.id ?? 1) { (result) in
            switch result{
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let data):
                self.episodes = data
                dump(data)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? EpisodeDetailVC, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("issue with segue")
        }
        detailVC.episode = episodes[indexPath.row]
    }

}

extension EpisodesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeCell else {
            fatalError("issue with cell")
        }
        
        let ep = episodes[indexPath.row]
        
        cell.configureEpCell(for: ep)
        return cell
    }
}
