//
//  AppError.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case badStatusCode(Int)
    case decodingError(Error)
    case missingValue
}
