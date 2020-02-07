//
//  TopStories.swift
//  Unit4Review
//
//  Created by casandra grullon on 2/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

enum ImageFormat: String {
    case superJumbo = "superJumbo"
    case thumbLarge = "thumbLarge"
    case normal = "Normal"
    case standardThumbnail = "Standard Thumbnail"
}

struct TopStories: Codable & Equatable {
    
    let section: String
    let lastUpdated: String
    let results: [Article]
    
    private enum CodingKeys: String, CodingKey {
        case section
        case lastUpdated = "last_updated"
        case results
    }
}
struct Article: Codable & Equatable {
    let section: String
    let title: String
    let abstract: String
    let publishedDate: String
    let multimedia: [Multimedia]
    let byline: String
    
    private enum CodingKeys: String, CodingKey {
        case section
        case title
        case abstract
        case publishedDate = "published_date"
        case multimedia
        case byline
    }
}
struct Multimedia: Codable & Equatable {
    let url: String
    let format: String // need superJumbo and thumbLarge
    let height: Double
    let width: Double
    let caption: String
}

extension Article {
    func getArticleImageURL(for imageFormat: ImageFormat) -> String {
        let results = multimedia.filter { $0.format == imageFormat.rawValue }
        
        guard let multimediaImage = results.first else {
            return ""
        }
        
        return multimediaImage.url
    }
}
