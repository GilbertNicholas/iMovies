//
//  GenreListViewController.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 13/1/23.
//

import UIKit

class GenreListViewController: UIViewController {
    var presenter: GenreListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
    }
}

extension GenreListViewController: GenreListPresenterToViewProtocol {
    func showGenres(genre: [Genre]) {
        //
    }
    
    func showError(error: String) {
        //
    }
}
