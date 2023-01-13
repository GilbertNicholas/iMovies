//
//  GenreListRouter.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 13/1/23.
//

import UIKit

class GenreListRouter: GenreListPresenterToRouterProtocol {
    static func createModule() -> UIViewController {
        let view = GenreListViewController()
        let interactor: GenreListPresenterToInteractorProtocol = GenreListInteractor()
        let presenter: GenreListViewToPresenterProtocol & GenreListInteractorToPresenterProtocol = GenreListPresenter()
        let router: GenreListPresenterToRouterProtocol = GenreListRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    func pushToMovieList(navCon: UINavigationController, genre: Genre) {
        //
    }
}
