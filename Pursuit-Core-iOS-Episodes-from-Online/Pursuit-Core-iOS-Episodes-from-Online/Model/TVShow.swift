//
//  TVShow.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct TVShow: Decodable {
    let show: Show
}
struct Show: Decodable{
    let id: Int?
    let url: String?
    let name: String?
    let rating: Rating?
    let image: ShowImage?
}
struct Rating: Decodable {
    let average: Double?
}
struct ShowImage: Decodable{
    let medium: String?
    let original: String?
    
}
