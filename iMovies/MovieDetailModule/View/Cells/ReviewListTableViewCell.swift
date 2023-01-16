//
//  ReviewListTableViewCell.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 16/1/23.
//

import UIKit

class ReviewListTableViewCell: UITableViewCell {
    static let id = "ReviewListCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.sizeToFit()
        return label
    }()
    
    let lineSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.opacity = 0.7
        return view
    }()
    
    private let seeMoreButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .small
        config.title = "see more"
        config.baseForegroundColor = .systemBlue
        return UIButton(configuration: config)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        self.backgroundColor = .black
        
        self.addSubview(nameLabel)
        nameLabel.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            paddingTop: 10,
            paddingLeft: 10
        )
        
        self.addSubview(reviewLabel)
        reviewLabel.anchor(
            top: nameLabel.bottomAnchor,
            left: nameLabel.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            paddingTop: 20,
            paddingBottom: 20,
            paddingRight: 10
        )
        
        self.addSubview(lineSeparator)
        lineSeparator.anchor(
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            height: 1
        )
        
//        self.addSubview(seeMoreButton)
//        seeMoreButton.anchor(
//            top: reviewLabel.bottomAnchor,
//            left: reviewLabel.leftAnchor,
//            bottom: self.bottomAnchor,
//            paddingTop: 5,
//            paddingBottom: 20
//        )
    }
    
    func configureLabelExpand() {
        
    }
    
    @objc func seeMoreButtonTapped() {
        self.reviewLabel.numberOfLines = 0
    }
}
