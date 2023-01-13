//
//  GenreListProtocols.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 13/1/23.
//

import UIKit

protocol GenreListViewToPresenterProtocol: AnyObject {
    var view: GenreListPresenterToViewProtocol? { get set }
    var interactor: GenreListPresenterToInteractorProtocol? { get set }
    var router: GenreListPresenterToRouterProtocol? { get set }
    
    func fetchGenres()
    func showMovieList(navCon: UINavigationController, genre: Genre)
}

protocol GenreListPresenterToViewProtocol: AnyObject {
    var presenter: GenreListViewToPresenterProtocol? { get set }
    
    func showGenres(genre: [Genre])
    func showError(error: String)
}

protocol GenreListInteractorToPresenterProtocol: AnyObject {
    func fetchGenreSuccess(genre: [Genre])
    func fetchGenreFailed(error: String)
}

protocol GenreListPresenterToInteractorProtocol: AnyObject {
    var presenter: GenreListInteractorToPresenterProtocol? { get set }
    func fetchGenre()
}

protocol GenreListPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func pushToMovieList(navCon: UINavigationController, genre: Genre)
}
