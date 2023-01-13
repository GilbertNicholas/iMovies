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
        
    }
}

extension GenreListViewController: GenreListPresenterToViewProtocol {
    func showGenres(genre: [Genre]) {
        <#code#>
    }
    
    func showError(error: String) {
        <#code#>
    }
}
