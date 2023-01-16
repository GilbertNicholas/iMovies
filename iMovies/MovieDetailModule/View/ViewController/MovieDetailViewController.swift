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
    private var reviewData: [Review] = []
    private var totalPageReview: Int = 0
    private var currentPage: Int = 1
    private var isLoading: Bool = false {
        didSet {
            if isLoading {
                loadIndicator.startAnimating()
            } else {
                loadIndicator.stopAnimating()
            }
        }
    }
    
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
    
    private let movieInfoPlaceholder = UIView()
    
    lazy var loadIndicator: UIActivityIndicatorView = {
        let loadIndicator = UIActivityIndicatorView()
        loadIndicator.hidesWhenStopped = true
        loadIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        loadIndicator.color = .white
        return loadIndicator
    }()
    
    private let movieDetailImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .yellow
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let ratingCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.layer.opacity = 0.7
        return label
    }()
    
    private let staticOverviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = StringPlaceholder.StaticOverview.rawValue
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .yellow
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.layer.opacity = 0.8
        return label
    }()
    
    private let staticReleaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = StringPlaceholder.StaticReleased.rawValue
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.opacity = 0.7
        return label
    }()
    
    private let staticReviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = StringPlaceholder.StaticReview.rawValue
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .yellow
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
        
        movieReviewTableView.delegate = self
        movieReviewTableView.dataSource = self
        movieReviewTableView.register(ReviewListTableViewCell.self, forCellReuseIdentifier: ReviewListTableViewCell.id)
        movieReviewTableView.backgroundColor = .black
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
            paddingTop: 15,
            paddingLeft: 15,
            width: view.frame.width / 3.5,
            height: view.frame.height / 5
        )
        
        movieInfoPlaceholder.addSubview(movieTitleLabel)
        movieTitleLabel.anchor(
            top: movieInfoPlaceholder.topAnchor,
            left: movieInfoPlaceholder.leftAnchor,
            right: movieInfoPlaceholder.rightAnchor
        )

        movieInfoPlaceholder.addSubview(starImage)
        starImage.anchor(
            top: movieTitleLabel.bottomAnchor,
            left: movieTitleLabel.leftAnchor,
            paddingTop: 10
        )

        movieInfoPlaceholder.addSubview(ratingLabel)
        ratingLabel.anchor(
            top: starImage.topAnchor,
            left: starImage.rightAnchor,
            paddingLeft: 5
        )
        
        movieInfoPlaceholder.addSubview(ratingCountLabel)
        ratingCountLabel.anchor(
            bottom: ratingLabel.bottomAnchor,
            right: movieInfoPlaceholder.rightAnchor,
            paddingRight: 5
        )
        
        movieInfoPlaceholder.addSubview(staticReleaseLabel)
        staticReleaseLabel.anchor(
            top: starImage.bottomAnchor,
            left: starImage.leftAnchor,
            paddingTop: 15
        )
        
        movieInfoPlaceholder.addSubview(releaseLabel)
        releaseLabel.anchor(
            top: staticReleaseLabel.topAnchor,
            left: staticReleaseLabel.rightAnchor,
            bottom: movieInfoPlaceholder.bottomAnchor,
            paddingLeft: 5
        )
        
        contentView.addSubview(movieInfoPlaceholder)
        movieInfoPlaceholder.centerY(inView: movieDetailImage)
        movieInfoPlaceholder.anchor(
            left: movieDetailImage.rightAnchor,
            right: contentView.rightAnchor,
            paddingLeft: 15,
            paddingRight: 10
        )
        
        contentView.addSubview(staticOverviewLabel)
        staticOverviewLabel.anchor(
            top: movieDetailImage.bottomAnchor,
            left: movieDetailImage.leftAnchor,
            paddingTop: 20
        )
        
        contentView.addSubview(overviewLabel)
        overviewLabel.anchor(
            top: staticOverviewLabel.bottomAnchor,
            left: staticOverviewLabel.leftAnchor,
            right: contentView.rightAnchor,
            paddingTop: 15,
            paddingRight: 15
        )
        
        contentView.addSubview(staticReviewLabel)
        staticReviewLabel.anchor(
            top: overviewLabel.bottomAnchor,
            left: overviewLabel.leftAnchor,
            paddingTop: 20
        )
        
        contentView.addSubview(movieReviewTableView)
        movieReviewTableView.anchor(
            top: staticReviewLabel.bottomAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: 15,
            height: view.frame.height / 2
        )
        
        contentView.addSubview(loadIndicator)
        loadIndicator.center(inView: movieReviewTableView)
    }
    
    @objc func fetchVideoTrailer() {
        presenter?.fetchMovieVideo(movieId: movieDetailData?.id)
    }
}

extension MovieDetailViewController: MovieDetailPresenterToViewProtocol {
    func loadMovieReview(reviewList: [Review], totalPage: Int) {
        self.totalPageReview = totalPage
        self.reviewData.append(contentsOf: reviewList)
        self.movieReviewTableView.reloadData()
        isLoading = false
    }
    
    func showMovieDetail(movieDetail: Movie) {
        self.movieDetailData = movieDetail
        
        let movieImage = presenter?.getImage(url: movieDetail.posterUrl)
        
        if let movieImage = movieImage as? URL {
            movieDetailImage.kf.setImage(with: movieImage)
        } else if let movieImage = movieImage as? UIImage {
            movieDetailImage.image = movieImage
        }
        
        movieTitleLabel.text = movieDetail.title
        starImage.image = UIImage(systemName: StringImagePlaceholder.StarRating.rawValue)
        ratingLabel.text = "\(movieDetail.voteAverage) / 10"
        ratingCountLabel.text = "\(movieDetail.voteCount) votes"
        releaseLabel.text = movieDetail.releaseDate
        overviewLabel.text = movieDetail.overview
        
        presenter?.fetchMovieVideo(movieId: movieDetailData?.id)
        isLoading = true
        presenter?.fetchMovieReview(movieId: movieDetailData?.id, page: 1)
    }

    func showError(error: String) {
        Utilities.showAlert(title: StringError.ErrorTitle.rawValue, message: error, viewController: self)
    }
    
    func loadVideoData(videoUrl: String) {
        self.videoPlayer.load(withVideoId: videoUrl)
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListTableViewCell.id, for: indexPath) as? ReviewListTableViewCell else {
            return UITableViewCell()
        }
        
        let usedReviewData = reviewData[indexPath.row]
        
        cell.selectionStyle = .none
        cell.nameLabel.text = usedReviewData.author
        cell.reviewLabel.text = usedReviewData.content
        cell.profileImage.image = UIImage(systemName: StringImagePlaceholder.UserProfile.rawValue)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height && !isLoading && currentPage < totalPageReview {
            self.isLoading = true
            self.currentPage += 1
            presenter?.fetchMovieReview(movieId: movieDetailData?.id, page: currentPage)
        }
    }
}


