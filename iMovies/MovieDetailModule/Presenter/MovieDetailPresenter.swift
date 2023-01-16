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
            interactor?.fetchMovieVideo(type: .RequestVideo, movieId: movieId, model: MovieVideoResponse.self, page: 1)
        } else {
            self.fetchDataFailed(error: StringError.FetchTrailerFailed.rawValue)
        }
    }
    
    func fetchMovieReview(movieId: Int?, page: Int) {
        if let movieId = movieId {
            interactor?.fetchMovieVideo(type: .RequestReview, movieId: movieId, model: ReviewListReponse.self, page: page)
        } else {
            self.fetchDataFailed(error: StringError.FetchReviewFailed.rawValue)
        }
    }
    
    func getImage(url: URL?) -> Any {
        return Utilities.guardUrlNil(url: url)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorToPresenterProtocol {
    func fetchReviewListSuccess(reviewList: ReviewListReponse) {
        if !reviewList.results.isEmpty {
            view?.configureTableViewHeight()
        }
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
