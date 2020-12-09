//
//  MovieTableViewCell.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/9/20.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movieImageView = UIImageView()
    var movieTitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        
        configureImageView()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie) {
        movieImageView.image = UIImage(named: "TMDB_logo")
        movieTitleLabel.text = movie.title
    }

    func configureImageView() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func configureTitleLabel() {
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
