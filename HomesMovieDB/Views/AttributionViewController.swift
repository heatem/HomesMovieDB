//
//  AttributionViewController.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/9/20.
//

import UIKit

class AttributionViewController: UIViewController {
    let tmdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "TMDB_logo")
        return imageView
    }()
    
    let dataSourceLabel: UILabel = {
        let label = UILabel()
        label.text = "This product uses the TMDb API but is not endorsed or certified by TMDb."
        label.textColor = UIColor.init(displayP3Red: 77/255.0, green: 177/255.0, blue: 223/255.0, alpha: 1.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 10
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tmdbImageView)
        view.addSubview(dataSourceLabel)
        
        installConstraints()
    }

    func installConstraints() {
        tmdbImageView.translatesAutoresizingMaskIntoConstraints = false
        tmdbImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        tmdbImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        tmdbImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tmdbImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        dataSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        dataSourceLabel.topAnchor.constraint(equalTo: tmdbImageView.bottomAnchor, constant: 20).isActive = true
        dataSourceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dataSourceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        dataSourceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }

}
