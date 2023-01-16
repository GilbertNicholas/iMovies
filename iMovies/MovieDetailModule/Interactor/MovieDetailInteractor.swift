//
//  MovieDetailInteractor.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 15/1/23.
//

import Alamofire

class MovieDetailInteractor: MovieDetailPresenterToInteractorProtocol {
    
    var presenter: MovieDetailInteractorToPresenterProtocol?
    
    var params: [String: String] = ["api_key": "6a6bf03b1bf7bfe41fcf8881cdcfa97d"]
    
    func fetchMovieVideo<T: Codable>(type: RequestType, movieId: Int, model: T.Type, page: Int) {
        let addUrl = type == .RequestReview ? RequestType.RequestReview.rawValue : RequestType.RequestVideo.rawValue
        let baseURL = "https://api.themoviedb.org/3/movie/\(movieId)/\(addUrl)"
        params["page"] = String(page)
        print(baseURL)
        AF.request(baseURL, parameters: params).responseDecodable(of: model) { response in
            switch response.result {
            case .success(let resp):
                if let resp = resp as? MovieVideoResponse {
                    self.presenter?.fetchMovieVideoSuccess(movieVideo: resp.results[0])
                } else if let resp = resp as? ReviewListReponse {
                    self.presenter?.fetchReviewListSuccess(reviewList: resp)
                }
            case .failure(let error):
                self.presenter?.fetchDataFailed(error: error.localizedDescription)
                print(error)
            }
        }
    }
}
