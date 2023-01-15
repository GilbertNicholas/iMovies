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
    
    func fetchMovieVideo(movieId: Int) {
        let baseURL = "https://api.themoviedb.org/3/movie/\(movieId)/videos"
        AF.request(baseURL, parameters: params).responseDecodable(of: MovieVideoResponse.self) { response in
            switch response.result {
            case .success(let resp):
                let newVideoData = self.mapVideoUrl(oldVideoData: resp.results)
                self.presenter?.fetchMovieVideoSuccess(movieVideo: newVideoData)
            case .failure(let error):
                self.presenter?.fetchMovieVideoFailed(error: error.localizedDescription)
                print("Debug: \(error)")
            }
        }
    }
    
    private func mapVideoUrl(oldVideoData: [Video]) -> Video {
        var newVideo = oldVideoData
        if newVideo.isEmpty {
            newVideo[0].videoUrl = nil
        } else {
            newVideo[0].videoUrl = self.getVideoURL(stringUrl: "https://www.youtube.com/watch?v=\(newVideo[0].key)")
        }
        return newVideo[0]
    }
    
    private func getVideoURL(stringUrl: String) -> URL? {
        return URL(string: stringUrl)
    }
}
