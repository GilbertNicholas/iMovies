//
//  MovieListTableViewCell.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import Foundation

import UIKit
import Kingfisher

class MovieListTableViewCell: UITableViewCell {
    static let id = StringPlaceholder.MovieListCellID.rawValue
    
    let movieImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let starImage: UIImageView = {
       let image = UIImageView()
        image.tintColor = .yellow
        return image
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.opacity = 0.5
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(StringError.InitCoderCellError.rawValue)
    }
    
    private func setupUI() {
        self.backgroundColor = .black
        self.addSubview(movieImage)
        movieImage.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            paddingTop: 10,
            paddingLeft: 15,
            paddingBottom: 10,
            width: self.frame.width / 3.5
        )
        
        self.addSubview(movieTitleLabel)
        movieTitleLabel.anchor(
            top: movieImage.topAnchor,
            left: movieImage.rightAnchor,
            right: self.rightAnchor,
            paddingTop: 5,
            paddingLeft: 15,
            paddingRight: 10
        )
        
        self.addSubview(releaseDateLabel)
        releaseDateLabel.anchor(
            top: movieTitleLabel.bottomAnchor,
            left: movieTitleLabel.leftAnchor,
            paddingTop: 5
        )
        
        self.addSubview(ratingLabel)
        ratingLabel.anchor(
            bottom: movieImage.bottomAnchor,
            right: self.rightAnchor,
            paddingRight: 20
        )
        
        self.addSubview(starImage)
        starImage.anchor(
            bottom: ratingLabel.bottomAnchor,
            right: ratingLabel.leftAnchor,
            paddingRight: 5
        )
    }
}
