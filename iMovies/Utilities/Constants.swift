//
//  Constants.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 16/1/23.
//

import Foundation

enum RequestType: String {
    case RequestReview = "reviews"
    case RequestVideo = "videos"
}

enum StringPlaceholder: String {
    case MovieGenreTitle = "Movie Genre"
    case Close = "Close"
    case StaticOverview = "OVERVIEW"
    case StaticReview = "REVIEW"
    case StaticReleased = "Released"
    
    case GenreListCellID = "GenreListCell"
    case MovieListCellID = "MovieListCell"
    case ReviewListCellID = "ReviewListCell"
}

enum StringError: String {
    case ErrorTitle = "Error!"
    case FetchTrailerFailed = "Failed Showing Trailer"
    case FetchReviewFailed = "Failed Showing Review"
    case DateformatError = "Unknown Date"
    case InitCoderCellError = "init(coder:) has not been implemented"
}

enum StringImagePlaceholder: String {
    case UserProfile = "person.fill"
    case NoImage = "trash.slash.fill"
    case StarRating = "star.fill"
}

enum StringDateFormat: String {
    case DateFormatJSON = "yyyy-MM-dd"
    case DateFormatUS = "MMM dd, yyyy"
    case DateYear = "yyyy"
}

enum PlistKey: String {
    case BaseURLPosterPath
    case BaseURLMovieDetail
    case BaseURLMovieList
    case BaseURLGenreList
    case APIKey
}
