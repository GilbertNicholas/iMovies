//
//  GenreListPresenter.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 13/1/23.
//

import UIKit

class GenreListPresenter: GenreListViewToPresenterProtocol {
    var view: GenreListPresenterToViewProtocol?
    
    var interactor: GenreListPresenterToInteractorProtocol?
    
    var router: GenreListPresenterToRouterProtocol?
    
    func fetchGenres() {
        interactor?.fetchGenre()
    }
    
    func showMovieList(navCon: UINavigationController, genre: Genre) {
        router?.pushToMovieList(navCon: navCon, genre: genre)
    }
}

extension GenreListPresenter: GenreListInteractorToPresenterProtocol {
    func fetchGenreSuccess(genre: [Genre]) {
        view?.showGenres(genre: genre)
    }
    
    func fetchGenreFailed(error: String) {
        view?.showError(error: error)
    }
}
