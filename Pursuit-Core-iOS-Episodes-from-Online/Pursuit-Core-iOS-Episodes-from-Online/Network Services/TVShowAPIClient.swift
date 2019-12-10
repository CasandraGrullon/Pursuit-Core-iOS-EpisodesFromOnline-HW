//
//  TVShowAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct TVShowAPI{
    static func getShows(for searchQuery: String, completion: @escaping (Result<[Show], AppError>) -> ()){
        
        let endpointURL = " https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let searchResults = try JSONDecoder().decode(TVShow.self, from: data)
                    let shows = searchResults.show
                    completion(.success(shows))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
