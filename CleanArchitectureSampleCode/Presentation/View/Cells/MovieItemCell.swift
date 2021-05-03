//
//  MovieItemCell.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/23.
//

import UIKit
import Kingfisher

class MovieItemCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    
    func configure(_ item: MovieItem) -> Self {
        selectionStyle = .none
        self.movieTitleLabel.text = item[keyPath: \.title]
        self.ratingLabel.text = "Popularity: " + String(item[keyPath: \.popularity])
        self.posterImageView.kf.setImage(with: URL(string: APIEndpoints.getImage(path: item[keyPath: \.posterPath])))
        self.backdropImageView.kf.setImage(with: URL(string: APIEndpoints.getImage(path: item[keyPath: \.backdropPath])))
        return self
    }
    
}
