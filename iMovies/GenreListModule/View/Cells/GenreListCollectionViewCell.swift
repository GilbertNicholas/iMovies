//
//  GenreListCollectionViewCell.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import UIKit

class GenreListCollectionViewCell: UICollectionViewCell {
    static let id = "GenreListCell"
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(genreLabelText: String) {
        self.layer.cornerRadius = 20
        self.backgroundColor = .black
        self.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel.text = genreLabelText
    }
}
