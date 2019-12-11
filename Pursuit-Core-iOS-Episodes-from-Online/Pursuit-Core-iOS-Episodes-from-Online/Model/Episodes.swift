//
//  Episodes.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episode: Decodable{
    let url: String
    let name: String
    let season: Int
    let number: Int
    let image: EpisodeImage?
    let summary: String?
    
}
struct EpisodeImage: Decodable {
    let medium: String?
    let original: String?
}
