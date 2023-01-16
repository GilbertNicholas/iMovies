//
//  MovieListInteractor.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import Alamofire

class MovieListInteractor: MovieListPresenterToInteractorProtocol {
    var presenter: MovieListInteractorToPresenterProtocol?
    
    let baseURL = Utilities.getInfoPlist(plistKey: PlistKey.BaseURLMovieList.rawValue)
    
    var params: [String: String] = [StringAPIRequest.APIKeyParam.rawValue: Utilities.getInfoPlist(plistKey: PlistKey.APIKey.rawValue)]
    
    func fetchMovieList(genreId: Int, page: Int) {
        params[StringAPIRequest.GenreParam.rawValue] = String(genreId)
        params[StringAPIRequest.PageParam.rawValue] = String(page)
        
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
                let basePosterUrl = Utilities.getInfoPlist(plistKey: PlistKey.BaseURLPosterPath.rawValue)
                newMovie.posterUrl = self.getImageURL(stringUrl: basePosterUrl + posterPathString)
            } else {
                newMovie.posterUrl = nil
            }
            return newMovie
        }
        return movieList
    }
    
    private func getImageURL(stringUrl: String) -> URL? {
        return URL(string: stringUrl)
    }
}
