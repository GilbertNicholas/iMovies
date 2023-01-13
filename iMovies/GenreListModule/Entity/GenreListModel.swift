//
//  GenreListModel.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 13/1/23.
//

import Foundation

class GenreResponse: Codable {
    var genres: [Genre]
}

class Genre: Codable {
    var id: Int
    var name: String
}
