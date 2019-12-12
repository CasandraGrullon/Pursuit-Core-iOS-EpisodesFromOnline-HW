//
//  Pursuit_Core_iOS_Episodes_from_OnlineTests.swift
//  Pursuit-Core-iOS-Episodes-from-OnlineTests
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import XCTest
@testable import Pursuit_Core_iOS_Episodes_from_Online

class Pursuit_Core_iOS_Episodes_from_OnlineTests: XCTestCase {

    func testSearchResults(){
        let searchQuery = "Steven Universe".lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let exp = XCTestExpectation(description: "search found")

        let endpointURL = "https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        TVShowAPI.getShows(for: endpointURL) { (result) in
            switch result{
            case .failure(let appError):
                XCTFail("app error: \(appError)")
            case .success:
                XCTAssertNotNil(true, "results not empty")
                exp.fulfill()
            }
        }
        wait(for:[exp] , timeout: 5.0)

    }

    func testEpisodesCount(){
        let showId = 169
        let expectedAmountOfEpisodes = 62
        let exp = XCTestExpectation(description: "id number found")
        
        EpisodeAPIClient.getEpisodes(for: showId) { (result) in
            switch result{
            case .failure(let appError):
                XCTFail("app error: \(appError)")
            case .success(let episodes):
                
                XCTAssertEqual(episodes.count, expectedAmountOfEpisodes, "should be 160")
                exp.fulfill()
            }
        }
        wait(for:[exp] , timeout: 5.0)

        
    }

}
