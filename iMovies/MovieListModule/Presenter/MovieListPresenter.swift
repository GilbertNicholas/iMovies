//
//  MovieListPresenter.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import UIKit

class MovieListPresenter: MovieListViewToPresenterProtocol {
    var view: MovieListPresenterToViewProtocol?
    
    var interactor: MovieListPresenterToInteractorProtocol?
    
    var router: MovieListPresenterToRouterProtocol?
    
    func fetchMovieList(genreId: Int, page: Int) {
        interactor?.fetchMovieList(genreId: genreId, page: page)
    }
    
    func showMovieDetail(navCon: UINavigationController, movie: Movie) {
        router?.pushToMovieDetailView(navCon: navCon, movie: movie)
    }
    
    func getImage(url: URL?) -> Any {
        return Utilities.guardUrlNil(url: url)
    }
}

extension MovieListPresenter: MovieListInteractorToPresenterProtocol {
    func fetchMovieListSuccess(movieListResponse: MovieListResponse) {
        let movieListDateUpdated = movieListResponse.results.map { movie in
            var newMovie = movie
            newMovie.releaseYear = getReleasedYear(date: newMovie.releaseDate, dateFormat: StringDateFormat.DateYear.rawValue)
            newMovie.releaseDate = getReleasedYear(date: newMovie.releaseDate, dateFormat: StringDateFormat.DateFormatUS.rawValue)
            return newMovie
        }
        view?.showMovieList(movieList: movieListDateUpdated, totalPageData: movieListResponse.totalPages)
    }
    
    func fetchMovieListFailed(error: String) {
        view?.showError(error: error)
    }
    
    private func getReleasedYear(date: String, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = StringDateFormat.DateFormatJSON.rawValue
        guard let date = dateFormatter.date(from: date) else { return StringError.DateformatError.rawValue }
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}

extension MovieListPresenter: MovieListRouterToPresenterProtocol {
    func passGenreData(genre: Genre) {
        view?.populateGenreData(genre: genre)
    }
}
