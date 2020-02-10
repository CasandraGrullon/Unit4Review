//
//  NYTTopStoriesAPIClient.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTTopStoriesAPIClient {
    static func fetchTopStories(for section: String, completion: @escaping (Result<[Article], AppError>) -> ()) {
        
        let endpointURL = "https://api.nytimes.com/svc/topstories/v2/\(section).json?api-key=\(Config.apiKey)"
        
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
                do {
                    let topStories = try JSONDecoder().decode(TopStories.self, from: data)
                    completion(.success(topStories.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
        }
        
    }
}
