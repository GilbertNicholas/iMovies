//
//  MovieDetailModel.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 15/1/23.
//

import Foundation

struct MovieVideoResponse: Codable {
    let id: Int
    let results: [Video]
}

struct Video: Codable {
    let key: String
    var videoUrl: URL?
}

struct ReviewListReponse: Codable {
    let id: Int
    let page: Int
    let totalPages: Int
    let results: [Review]
    
    private enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
    }
}

struct Review: Codable {
    let author: String
    let content: String
}
