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
    
    func fetchMovieList(genreId: Int, page: Int) {
        params["with_genres"] = String(genreId)
        params["page"] = String(page)
        AF.request(baseURL, parameters: params).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result {
                case .success(var response):
                response.results = self.mapNewPosterUrl(oldMovieList: response.results)
                self.presenter?.fetchMovieListSuccess(movieListResponse: response)
                
                case .failure(let error):
                self.presenter?.fetchMovieListFailed(error: error.localizedDescription)
            }
        }
    }
    
    private func mapNewPosterUrl(oldMovieList: [Movie]) -> [Movie] {
        let movieList = oldMovieList.map { movie in
            var newMovie = movie
            if let posterPathString = newMovie.posterPath {
                newMovie.posterUrl = self.getImageURL(stringUrl: "https://image.tmdb.org/t/p/w342\(posterPathString)")
            } else {
                newMovie.posterUrl = nil
            }
            
            if let backdropPathString = newMovie.backdropPath {
                newMovie.backdropUrl = self.getImageURL(stringUrl: "https://image.tmdb.org/t/p/w342\(backdropPathString)")
            } else {
                newMovie.backdropUrl = nil
            }
            return newMovie
        }
        return movieList
    }
    
    private func getImageURL(stringUrl: String) -> URL? {
        return URL(string: stringUrl)
    }
}
