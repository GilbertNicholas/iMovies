//
//  MovieDetailViewController.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 15/1/23.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailViewToPresenterProtocol?
    
    private var movieDetailData: Movie?
    
    private lazy var movieReviewTableView: UITableView = UITableView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let videoPlayer = YTPlayerView()
    private let videoPlaceholder = UIView()
    
    private let movieBackdropImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private let imageGradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        return gradient
    }()
    
    private let movieDetailImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let starImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .yellow
        return image
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let ratingCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let staticOverviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Overview"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    private let staticReleaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Released"
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .never
        
//        movieReviewTableView.delegate = self
//        movieReviewTableView.dataSource = self
//        movieReviewTableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.id)
//        movieReviewTableView.backgroundColor = .black
//        imageGradientLayer.frame = movieBackdropImage.bounds
        videoPlayer.backgroundColor = .black
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.centerX(inView: view)
        scrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.bottomAnchor,
            widthAnc: view.widthAnchor
        )

        scrollView.addSubview(contentView)
        contentView.centerX(inView: scrollView)
        contentView.anchor(
            top: scrollView.topAnchor,
            bottom: scrollView.bottomAnchor,
            widthAnc: scrollView.widthAnchor
        )

        contentView.addSubview(videoPlayer)
        videoPlayer.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            height: view.frame.height / 3.5
        )
        
        contentView.addSubview(movieDetailImage)
        movieDetailImage.anchor(
            top: videoPlayer.bottomAnchor,
            left: contentView.leftAnchor,
            paddingTop: 10,
            paddingLeft: 15,
            width: view.frame.width / 3.5,
            height: view.frame.height / 5
        )
        
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.anchor(
            top: videoPlayer.bottomAnchor,
            left: movieDetailImage.rightAnchor,
            right: contentView.rightAnchor,
            paddingTop: 15,
            paddingLeft: 15,
            paddingRight: 10
        )

        contentView.addSubview(starImage)
        starImage.anchor(
            top: movieTitleLabel.bottomAnchor,
            left: movieTitleLabel.leftAnchor,
            paddingTop: 5
        )

        contentView.addSubview(ratingLabel)
        ratingLabel.anchor(
            top: starImage.topAnchor,
            left: starImage.rightAnchor,
            paddingLeft: 5
        )
        
        contentView.addSubview(staticReleaseLabel)
        staticReleaseLabel.anchor(
            top: movieDetailImage.bottomAnchor,
            left: movieDetailImage.leftAnchor,
            paddingTop: 15
        )
        
        contentView.addSubview(releaseLabel)
        releaseLabel.anchor(
            left: staticReleaseLabel.rightAnchor,
            bottom: staticReleaseLabel.bottomAnchor,
            paddingLeft: 5
        )
        
        contentView.addSubview(staticOverviewLabel)
        staticOverviewLabel.anchor(
            top: staticReleaseLabel.bottomAnchor,
            left: staticReleaseLabel.leftAnchor,
            paddingTop: 20
        )
        
        contentView.addSubview(overviewLabel)
        overviewLabel.anchor(
            top: staticOverviewLabel.bottomAnchor,
            left: staticOverviewLabel.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: 15,
            paddingRight: 15
        )
    }
    
    @objc func fetchVideoTrailer() {
        presenter?.fetchMovieVideo(movieId: movieDetailData?.id)
    }
}

extension MovieDetailViewController: MovieDetailPresenterToViewProtocol {
    
    func showMovieDetail(movieDetail: Movie) {
        self.movieDetailData = movieDetail
        let backDropImage = presenter?.getImage(url: movieDetail.backdropUrl)
        
        if let backdropUrl = backDropImage as? URL {
            movieBackdropImage.kf.setImage(with: backdropUrl)
        } else if let backDropImage = backDropImage as? UIImage {
            movieBackdropImage.image = backDropImage
        }
        
        let movieImage = presenter?.getImage(url: movieDetail.posterUrl)
        
        if let movieImage = movieImage as? URL {
            movieDetailImage.kf.setImage(with: movieImage)
        } else if let movieImage = movieImage as? UIImage {
            movieDetailImage.image = movieImage
        }
        
        movieTitleLabel.text = movieDetail.title
        starImage.image = UIImage(systemName: "star.fill")
        ratingLabel.text = "\(movieDetail.voteAverage) / 10"
        releaseLabel.text = movieDetail.releaseDate
        overviewLabel.text = movieDetail.overview
        
        presenter?.fetchMovieVideo(movieId: movieDetailData?.id)
    }

    func showError(error: String) {
        //
    }
    
    func loadVideoData(videoUrl: String) {
        videoPlayer.load(withVideoId: videoUrl)
    }
}

//extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //
//    }
//}


