//
//  MovieDetailPresenter.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 15/1/23.
//

import UIKit

class MovieDetailPresenter: MovieDetailViewToPresenterProtocol {
    func fetchMovieReview(movieId: Int?, page: Int) {
        if let movieId = movieId {
            interactor?.fetchMovieVideo(type: .RequestReview, movieId: movieId, model: ReviewListReponse.self, page: page)
        }
    }
    
    var view: MovieDetailPresenterToViewProtocol?
    
    var interactor: MovieDetailPresenterToInteractorProtocol?
    
    var router: MovieDetailPresenterToRouterProtocol?
    
    func fetchMovieVideo(movieId: Int?) {
        if let movieId = movieId {
            interactor?.fetchMovieVideo(type: .RequestVideo, movieId: movieId, model: MovieVideoResponse.self, page: 1)
        } else {
            self.fetchDataFailed(error: "Failed Showing Trailer")
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
    func fetchReviewListSuccess(reviewList: ReviewListReponse) {
        view?.loadMovieReview(reviewList: reviewList.results, totalPage: reviewList.totalPages)
    }
    
    func fetchMovieVideoSuccess(movieVideo: Video) {
        view?.loadVideoData(videoUrl: movieVideo.key)
    }
    
    func fetchDataFailed(error: String) {
        view?.showError(error: error)
    }
}

extension MovieDetailPresenter: MovieDetailRouterToPresenterProtocol {
    func passMovieData(movieDetail: Movie) {
        view?.showMovieDetail(movieDetail: movieDetail)
    }
}
