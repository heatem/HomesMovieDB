//
//  MovieView.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/14/20.
//

import UIKit

class MovieView: UIView {
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "TMDB_logo")
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .left
        return label
    }()

    let voteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .left
        return label
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let saveButton = SaveButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(saveButton)
        addSubview(releaseDateLabel)
        addSubview(voteLabel)
        addSubview(overviewLabel)
        
        installConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/2).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        saveButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 40).isActive = true

        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -16).isActive = true
        releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true

        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        voteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        voteLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -16).isActive = true
        voteLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8).isActive = true

        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        overviewLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -32).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: voteLabel.bottomAnchor, constant: 16).isActive = true
    }
}
