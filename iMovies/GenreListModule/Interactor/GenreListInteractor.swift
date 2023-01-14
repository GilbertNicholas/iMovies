//
//  GenreListInteractor.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 13/1/23.
//

import Alamofire

class GenreListInteractor: GenreListPresenterToInteractorProtocol {
    var presenter: GenreListInteractorToPresenterProtocol?
    
    let baseUrl = "https://api.themoviedb.org/3/genre/movie/list"
    
    let params: [String: String] = ["api_key": "6a6bf03b1bf7bfe41fcf8881cdcfa97d", "language": "en-US"]
    
    func fetchGenre() {
        AF.request(baseUrl, parameters: params).responseDecodable(of: GenreResponse.self) { [weak self] genreResponse in
            switch genreResponse.result {
            case .success(let resp):
                self?.presenter?.fetchGenreSuccess(genre: resp.genres)
            case .failure(let error):
                self?.presenter?.fetchGenreFailed(error: error.localizedDescription)
            }
        }
    }
}
