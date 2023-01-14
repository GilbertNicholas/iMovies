//
//  MovieListProtocols.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import UIKit

protocol MovieListViewToPresenterProtocol: AnyObject {
    var view: MovieListPresenterToViewProtocol? { get set }
    var interactor: MovieListPresenterToInteractor? { get set }
    var router: MovieListPresenterToRouter? { get set }
    
    func fetchMovieList(genreId: Int)
    func showMovieDetail(navCon: UINavigationController)
}

protocol MovieListPresenterToViewProtocol: AnyObject {
    var presenter: MovieListViewToPresenterProtocol? { get set }
    
    func showMovieList(movieList: [Movie])
    func showError(error: String)
}

protocol MovieListInteractorToPresenter: AnyObject {
    func fetchMovieListSuccess(movieList: [Movie])
    func fetchMovieListFailes(error: String)
}

protocol MovieListPresenterToInteractor: AnyObject {
    var presenter: MovieListInteractorToPresenter? { get set }
    func fetchMovieList(genreId: Int)
}

protocol MovieListPresenterToRouter: AnyObject {
    static func createModule() -> UIViewController
    func pushToMovieDetailView(movie: Movie)
}
