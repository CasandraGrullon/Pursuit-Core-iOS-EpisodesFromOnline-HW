//
//  EpisodeDetailVC.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeDetailVC: UIViewController {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var seasonEpisodeNumber: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var episode: Episode?
    var tvshow: Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    func updateUI(){
        guard let ep = episode else {
            return
        }
        episodeName.text = ep.name
        seasonEpisodeNumber.text = "s:\(ep.season),e:\(ep.number)"
        descriptionText.text = ep.summary?.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "") ?? "no summary"
        
        guard let url = URL(string: episode?.image?.original ?? "https://images.dog.ceo/breeds/terrier-westhighland/n02098286_238.jpg" ) else {
            print("bad pic")
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                print("apperror: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.episodeImage.image = UIImage(data: image)
                }
            }
        }
    }


}
