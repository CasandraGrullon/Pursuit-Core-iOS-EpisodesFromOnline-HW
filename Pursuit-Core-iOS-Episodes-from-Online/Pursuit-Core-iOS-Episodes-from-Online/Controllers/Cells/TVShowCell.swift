//
//  TVShowCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class TVShowCell: UITableViewCell {

    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var tvShow: Show?
    
    func configureCell(for tvShow: Show){
        
        nameLabel.text = tvShow.name
        ratingLabel.text = tvShow.rating?.average?.description
        
        guard let url = URL(string: tvShow.image?.medium ?? "") else {
            print("TV ShowCell picture no bueno \(tvShow.image?.medium?.description)")
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request ) { (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.showImageView.image = UIImage(data: image)
                }
            
            }
        }
    }
    
}
