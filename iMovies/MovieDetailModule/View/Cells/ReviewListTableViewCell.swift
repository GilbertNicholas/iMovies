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
        label.layer.opacity = 0.8
        return label
    }()
    
    let lineSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.opacity = 0.7
        return view
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .lightGray
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.gray.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
    private func setupUI() {
        self.backgroundColor = .black
        
        self.addSubview(profileImage)
        profileImage.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            width: 30,
            height: 30
        )
        
        self.addSubview(nameLabel)
        nameLabel.anchor(
            top: profileImage.topAnchor,
            left: profileImage.rightAnchor,
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
    }
}
