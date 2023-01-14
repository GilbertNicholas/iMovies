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
        router?.pushToMovieDetailView(movie: movie)
    }
    
    func getImage(url: URL?) -> Any {
        if let url = url {
            return url
        }
        return UIImage()
    }
}

extension MovieListPresenter: MovieListInteractorToPresenterProtocol {
    func fetchMovieListSuccess(movieListResponse: MovieListResponse) {
        let movieListDateUpdated = movieListResponse.results.map { movie in
            var newMovie = movie
            newMovie.releaseYear = getReleasedYear(date: newMovie.releaseDate, dateFormat: "yyyy")
            newMovie.releaseDate = getReleasedYear(date: newMovie.releaseDate, dateFormat: "dd/MM/yyyy")
            return newMovie
        }
        view?.showMovieList(movieList: movieListDateUpdated, totalPageData: movieListResponse.totalPages)
    }
    
    func fetchMovieListFailed(error: String) {
        view?.showError(error: error)
    }
    
    private func getReleasedYear(date: String, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: date) else { return "Unknown Date" }
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}

extension MovieListPresenter: MovieListRouterToPresenterProtocol {
    func passGenreData(genre: Genre) {
        view?.populateGenreData(genre: genre)
    }
}
