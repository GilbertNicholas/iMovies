//
//  MovieListModel.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import UIKit

struct MovieListResponse: Codable {
    let page: Int
    var results: [Movie]
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

struct Movie: Codable {
    let genreIds: [Int]
    let id: Int
    let overview: String
    let posterPath: String?
    var posterUrl: URL?
    var posterPlaceholder: UIImage?
    var releaseDate: String
    var releaseYear: String?
    let title: String
    let voteAverage: Double
    let voteCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, overview, title, releaseYear
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
