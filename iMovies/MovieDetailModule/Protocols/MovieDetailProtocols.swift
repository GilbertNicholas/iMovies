//
//  MovieDetailProtocols.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 15/1/23.
//

import UIKit

protocol MovieDetailViewToPresenterProtocol: AnyObject {
    var view: MovieDetailPresenterToViewProtocol? { get set }
    var interactor: MovieDetailPresenterToInteractorProtocol? { get set }
    var router: MovieDetailPresenterToRouterProtocol? { get set }
    
    func fetchMovieVideo(movieId: Int?)
    func getImage(url: URL?) -> Any
    func fetchMovieReview(movieId: Int?, page: Int)
}

protocol MovieDetailPresenterToViewProtocol: AnyObject {
    var presenter: MovieDetailViewToPresenterProtocol? { get set }
    
    func showMovieDetail(movieDetail: Movie)
    func showError(error: String)
    func loadVideoData(videoUrl: String)
    func loadMovieReview(reviewList: [Review], totalPage: Int)
    func configureTableViewHeight()
}

protocol MovieDetailInteractorToPresenterProtocol: AnyObject {
    func fetchMovieVideoSuccess(movieVideo: Video)
    func fetchReviewListSuccess(reviewList: ReviewListReponse)
    func fetchDataFailed(error: String)
}

protocol MovieDetailPresenterToInteractorProtocol: AnyObject {
    var presenter: MovieDetailInteractorToPresenterProtocol? { get set }
    func fetchMovieVideo<T: Codable>(type: RequestType, movieId: Int, model: T.Type, page: Int)
}

protocol MovieDetailRouterToPresenterProtocol: AnyObject {
    func passMovieData(movieDetail: Movie)
}

protocol MovieDetailPresenterToRouterProtocol: AnyObject {
    var presenter: MovieDetailInteractorToPresenterProtocol? { get set }
    
    static func createModule(movieDetail: Movie) -> UIViewController
}
