//
//  MovieListInteractor.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import Alamofire

class MovieListInteractor: MovieListPresenterToInteractorProtocol {
    var presenter: MovieListInteractorToPresenterProtocol?
    
    let baseURL = "https://api.themoviedb.org/3/discover/movie"
    
    var params: [String: String] = ["api_key": "6a6bf03b1bf7bfe41fcf8881cdcfa97d"]
    
    func fetchMovieList(genreId: Int) {
        params["with_genres"] = String(genreId)
        AF.request(baseURL, parameters: params).responseDecodable(of: MovieListResponse.self) { [weak self] response in
            switch response.result {
                case .success(let response):
                    let movieList = response.results.map { movie in
                        var newMovie = movie
                        newMovie.posterUrl = self?.getPosterURL(stringUrl: "https://image.tmdb.org/t/p/w342\(newMovie.posterPath)")
                        return newMovie
                    }
                    self?.presenter?.fetchMovieListSuccess(movieList: movieList)
                case .failure(let error):
                    self?.presenter?.fetchMovieListFailed(error: error.localizedDescription)
            }
        }
    }
    
    private func getPosterURL(stringUrl: String) -> URL? {
        return URL(string: stringUrl)
    }
}
