//
//  MovieListRouter.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import UIKit

class MovieListRouter: MovieListPresenterToRouterProtocol {
    var presenter: MovieListRouterToPresenterProtocol?
    
    static func createModule(genre: Genre) -> UIViewController {
        let view = MovieListViewController()
        let interactor: MovieListPresenterToInteractorProtocol = MovieListInteractor()
        let presenter: MovieListViewToPresenterProtocol & MovieListInteractorToPresenterProtocol & MovieListRouterToPresenterProtocol = MovieListPresenter()
        let router: MovieListPresenterToRouterProtocol = MovieListRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        
        presenter.passGenreData(genre: genre)
        
        return view
    }
    
    func pushToMovieDetailView(navCon: UINavigationController, movie: Movie) {
        let movieDetailVC = MovieDetailRouter.createModule(movieDetail: movie)
        navCon.pushViewController(movieDetailVC, animated: true)
    }
}
