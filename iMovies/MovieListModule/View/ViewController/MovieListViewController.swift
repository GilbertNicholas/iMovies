//
//  MovieListViewController.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var presenter: MovieListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        
    }
    
}

extension MovieListViewController: MovieListPresenterToViewProtocol {
    func populateGenreData(genre: Genre) {
        //
    }
    
    func showMovieList(movieList: [Movie]) {
        //
    }
    
    func showError(error: String) {
        //
    }
}
