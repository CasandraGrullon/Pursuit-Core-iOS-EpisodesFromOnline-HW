//
//  EpisodeCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by casandra grullon on 12/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeSeasonNumberLabel: UILabel!
    
    var episodes: Episode?

    
    func configureEpCell(for episode: Episode){
        episodeTitleLabel.text = episode.name
        episodeSeasonNumberLabel.text = "s:\(episode.season)e:\(episode.number)"
        
        guard let url = URL(string: episode.image?.medium ?? "https://images.dog.ceo/breeds/terrier-westhighland/n02098286_238.jpg") else{
            print("EpisodeCell picture no bueno")
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                print("episode cell pic app error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.episodeImageView.image = UIImage(data: image)
                }
            }
        }
    }
    
}
