//
//  GenreListViewController.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 13/1/23.
//

import UIKit

class GenreListViewController: UIViewController, GenreListPresenterToViewProtocol {
    
    private var genreListCollectionView: UICollectionView?
    
    var presenter: GenreListViewToPresenterProtocol?
    
    private var genreData: [Genre] = []
    
    lazy var loadIndicator: UIActivityIndicatorView = {
        let loadIndicator = UIActivityIndicatorView()
        loadIndicator.hidesWhenStopped = true
        loadIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        loadIndicator.color = .gray
        return loadIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        initView()
    }
    
    private func initView() {
        loadIndicator.startAnimating()
        presenter?.fetchGenres()
    }
    
    private func setupView() {
        self.title = "Movie Category"
        view.backgroundColor = .systemBackground
        
        let colViewLayout = UICollectionViewFlowLayout()
        colViewLayout.scrollDirection = .vertical
        colViewLayout.minimumLineSpacing = 40
        genreListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: colViewLayout)
    }
    
    private func setupLayout() {
        guard let categoryColView = genreListCollectionView else { return }
        categoryColView.register(GenreListCollectionViewCell.self, forCellWithReuseIdentifier: GenreListCollectionViewCell.id)
        
        view.addSubview(categoryColView)
        categoryColView.delegate = self
        categoryColView.dataSource = self
        categoryColView.translatesAutoresizingMaskIntoConstraints = false
        categoryColView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        categoryColView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        categoryColView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        categoryColView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(loadIndicator)
        loadIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showGenres(genre: [Genre]) {
        self.genreData = genre
        genreListCollectionView?.reloadData()
    }
    
    func showError(error: String) {
//        Utilities.showAlert(title: "Fetch Categories Error", message: error, viewController: self)
    }
    
    func configureLoadingIndicator(isLoad: Bool) {
        if isLoad {
            loadIndicator.startAnimating()
        } else {
            loadIndicator.stopAnimating()
        }
    }
}

extension GenreListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:    GenreListCollectionViewCell.id, for: indexPath) as? GenreListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureUI(genreLabelText: genreData[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navCon = self.navigationController else { return }
        presenter?.showMovieList(navCon: navCon, genre: genreData[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.8, height: view.frame.height / 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 20, right: 0)
    }
}

