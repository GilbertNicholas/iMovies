//
//  GenreListCollectionViewCell.swift
//  iMovies
//
//  Created by Gilbert Nicholas on 14/1/23.
//

import UIKit

class GenreListCollectionViewCell: UICollectionViewCell {
    static let id = StringPlaceholder.GenreListCellID.rawValue
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError(StringError.InitCoderCellError.rawValue)
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
