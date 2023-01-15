//
//  MovieDetailPresenter.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 15/1/23.
//

import UIKit

class MovieDetailPresenter: MovieDetailViewToPresenterProtocol {
    var view: MovieDetailPresenterToViewProtocol?
    
    var interactor: MovieDetailPresenterToInteractorProtocol?
    
    var router: MovieDetailPresenterToRouterProtocol?
    
    func fetchMovieVideo(movieId: Int?) {
        if let movieId = movieId {
            interactor?.fetchMovieVideo(movieId: movieId)
        } else {
            self.fetchMovieVideoFailed(error: "Failed Showing Trailer")
        }
    }
    
    func getImage(url: URL?) -> Any {
        if let url = url {
            return url
        }
        return UIImage()
    }
}

extension MovieDetailPresenter: MovieDetailInteractorToPresenterProtocol {
    func fetchMovieVideoSuccess(movieVideo: Video) {
        view?.loadVideoData(videoUrl: movieVideo.key)
//        if let videoUrl = movieVideo.videoUrl {
//            view?.loadVideoData(videoUrl: videoUrl)
//        } else {
//            self.fetchMovieVideoFailed(error: "Video trailer not exist")
//        }
    }
    
    func fetchMovieVideoFailed(error: String) {
        view?.showError(error: error)
    }
}

extension MovieDetailPresenter: MovieDetailRouterToPresenterProtocol {
    func passMovieData(movieDetail: Movie) {
        view?.showMovieDetail(movieDetail: movieDetail)
    }
}
