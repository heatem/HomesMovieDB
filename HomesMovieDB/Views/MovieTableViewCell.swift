//
//  MovieTableViewCell.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/9/20.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "TMDB_logo")
        // TODO: Do I need this?
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // TODO: adjust things based on title length
    var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // TODO: Format date
    var dateScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.lineBreakMode = .byWordWrapping
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(dateScoreLabel)
        addSubview(overviewLabel)
        
        configureImageView()
        configureTitleLabel()
        configureDateScoreLabel()
        configureOverviewLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie) {
        if let posterPath = movie.poster_path {
            getPoster(from: posterPath) { (imageData) in
                if let data = imageData {
                    DispatchQueue.main.async {
                        self.movieImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        movieTitleLabel.text = movie.title
        let releaseDate = movie.release_date ?? "Date Not Available"
        if let voteAverage = movie.vote_average {
            dateScoreLabel.text = "\(releaseDate) | Score: \(voteAverage)"
        } else {
            dateScoreLabel.text = releaseDate
        }
        overviewLabel.text = movie.overview
    }

    func configureImageView() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        movieImageView.widthAnchor.constraint(lessThanOrEqualTo: movieImageView.heightAnchor, multiplier: 2/3).isActive = true
    }
    
    func configureTitleLabel() {
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    }
    
    func configureDateScoreLabel() {
        dateScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        dateScoreLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16).isActive = true
        dateScoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        dateScoreLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 6).isActive = true
    }
    
    func configureOverviewLabel() {
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: dateScoreLabel.bottomAnchor, constant: 6).isActive = true
    }
}
