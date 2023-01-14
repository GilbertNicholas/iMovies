//
//  GenreListModel.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 13/1/23.
//

import Foundation

class GenreResponse: Codable {
    let genres: [Genre]
}

class Genre: Codable {
    let id: Int
    let name: String
}
