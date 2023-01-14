//
//  MovieListProtocols.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import UIKit

protocol MovieListViewToPresenterProtocol: AnyObject {
    var view: MovieListPresenterToViewProtocol? { get set }
    var interactor: MovieListPresenterToInteractorProtocol? { get set }
    var router: MovieListPresenterToRouterProtocol? { get set }
    
    func fetchMovieList(genreId: Int)
    func showMovieDetail(navCon: UINavigationController, movie: Movie)
    func getImage(url: URL?) -> Any
}

protocol MovieListPresenterToViewProtocol: AnyObject {
    var presenter: MovieListViewToPresenterProtocol? { get set }
    
    func showMovieList(movieList: [Movie])
    func showError(error: String)
    func populateGenreData(genre: Genre)
}

protocol MovieListInteractorToPresenterProtocol: AnyObject {
    func fetchMovieListSuccess(movieList: [Movie])
    func fetchMovieListFailed(error: String)
}

protocol MovieListPresenterToInteractorProtocol: AnyObject {
    var presenter: MovieListInteractorToPresenterProtocol? { get set }
    func fetchMovieList(genreId: Int)
}

protocol MovieListPresenterToRouterProtocol: AnyObject {
    var presenter: MovieListRouterToPresenterProtocol? { get set }
    static func createModule(genre: Genre) -> UIViewController
    func pushToMovieDetailView(movie: Movie)
}

protocol MovieListRouterToPresenterProtocol: AnyObject {
    func passGenreData(genre: Genre)
}
