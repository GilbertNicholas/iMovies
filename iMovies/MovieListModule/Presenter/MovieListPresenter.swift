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
    
    func fetchMovieList(genreId: Int) {
        interactor?.fetchMovieList(genreId: genreId)
    }
    
    func showMovieDetail(navCon: UINavigationController, movie: Movie) {
        router?.pushToMovieDetailView(movie: movie)
    }
}

extension MovieListPresenter: MovieListInteractorToPresenterProtocol {
    func fetchMovieListSuccess(movieList: [Movie]) {
        view?.showMovieList(movieList: movieList)
    }
    
    func fetchMovieListFailes(error: String) {
        view?.showError(error: error)
    }
}

extension MovieListPresenter: MovieListRouterToPresenterProtocol {
    func passGenreData(genre: Genre) {
        view?.populateGenreData(genre: genre)
    }
}
