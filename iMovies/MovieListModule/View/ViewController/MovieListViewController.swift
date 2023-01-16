//
//  MovieListViewController.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var presenter: MovieListViewToPresenterProtocol?
    
    private var genreMovieList: Genre?
    private var movieListData: [Movie] = []
    private var currentPage: Int = 1
    private var totalPage: Int = 0
    private var isLoading: Bool = false {
        didSet {
            if isLoading {
                loadIndicator.startAnimating()
            } else {
                loadIndicator.stopAnimating()
            }
        }
    }
    
    private lazy var movieListTableView: UITableView = UITableView()
    
    lazy var loadIndicator: UIActivityIndicatorView = {
        let loadIndicator = UIActivityIndicatorView()
        loadIndicator.hidesWhenStopped = true
        loadIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        loadIndicator.color = .white
        return loadIndicator
    }()
    
    override func viewDidLoad() {
        setupView()
        setupLayout()
        loadMovieListData(genreId: genreMovieList?.id, page: currentPage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    private func setupView() {
        guard let genreMovieList = genreMovieList else { return }
        
        self.title = genreMovieList.name
        navigationController?.navigationBar.tintColor = UIColor.white
        
        self.view.backgroundColor = .black
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.id)
        movieListTableView.backgroundColor = .black
    }
    
    private func setupLayout() {
        view.addSubview(movieListTableView)
        movieListTableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        view.addSubview(loadIndicator)
        loadIndicator.center(inView: view)
    }
    
    private func loadMovieListData(genreId: Int?, page: Int) {
        guard let genreId = genreId else { return }
        isLoading = true
        presenter?.fetchMovieList(genreId: genreId, page: page)
    }
}

extension MovieListViewController: MovieListPresenterToViewProtocol {
    func populateGenreData(genre: Genre) {
        self.genreMovieList = genre
    }
    
    func showMovieList(movieList: [Movie], totalPageData: Int) {
        self.totalPage = totalPageData
        self.movieListData.append(contentsOf: movieList)
        self.movieListTableView.reloadData()
        isLoading = false
    }
    
    func showError(error: String) {
        Utilities.showAlert(title: "Fetch Movie List Error", message: error, viewController: self)
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.id, for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        let movieData = movieListData[indexPath.row]
        let movieImage = presenter?.getImage(url: movieData.posterUrl)
        
        if let url = movieImage as? URL {
            cell.movieImage.kf.setImage(with: url)
        } else if let image = movieImage as? UIImage {
            cell.movieImage.image = image
        }
        cell.movieTitleLabel.text = movieData.title
        cell.releaseDateLabel.text = movieData.releaseYear
        cell.ratingLabel.text = "\(movieData.voteAverage)/10"
        cell.starImage.image = UIImage(systemName: "star.fill")
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navCon = self.navigationController else { return }
        presenter?.showMovieDetail(navCon: navCon, movie: movieListData[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height && !isLoading && currentPage < totalPage {
            self.isLoading = true
            self.currentPage += 1
            loadMovieListData(genreId: genreMovieList?.id, page: currentPage)
        }
    }
}
