//
//  EpisodeAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct EpisodeAPIClient{
    static func getEpisodes(for showId: Int, completion: @escaping(Result<[Episode], AppError>) -> ()){
        let endpointURL = "http://api.tvmaze.com/shows/\(showId)/episodes"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let searchResults = try JSONDecoder().decode([Episode].self, from: data)
                    let tvEpisodes = searchResults
                    completion(.success(tvEpisodes))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
