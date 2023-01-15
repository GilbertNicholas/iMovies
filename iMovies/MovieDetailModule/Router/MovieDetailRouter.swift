//
//  MovieDetailRouter.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 15/1/23.
//

import UIKit

class MovieDetailRouter: MovieDetailPresenterToRouterProtocol {
    var presenter: MovieDetailInteractorToPresenterProtocol?
    
    static func createModule(movieDetail: Movie) -> UIViewController {
        let view = MovieDetailViewController()
        let interactor: MovieDetailPresenterToInteractorProtocol = MovieDetailInteractor()
        let presenter: MovieDetailViewToPresenterProtocol & MovieDetailInteractorToPresenterProtocol & MovieDetailRouterToPresenterProtocol = MovieDetailPresenter()
        let router: MovieDetailPresenterToRouterProtocol = MovieDetailRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        
        presenter.passMovieData(movieDetail: movieDetail)
        
        return view
    }
}
