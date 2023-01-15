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
    let adult: Bool
    let backdropPath: String?
    var backdropUrl: URL?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    var posterUrl: URL?
    var posterPlaceholder: UIImage?
    var releaseDate: String
    var releaseYear: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case adult, id, overview, popularity, title, video, releaseYear
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
