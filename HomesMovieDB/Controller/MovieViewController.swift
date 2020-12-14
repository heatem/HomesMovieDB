//
//  MovieViewController.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/12/20.
//

import UIKit

class MovieViewController: UIViewController {
    var movie = Movie(id: 1, title: "hello", overview: "blah blah blah", release_date: "2020-12-12", poster_path: "/eLT8Cu357VOwBVTitkmlDEg32Fs.jpg", vote_average: 7.9)
    
    let movieView = MovieView()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        // TODO: Make this dynamic
        view.contentSize.height = 1000
        view.backgroundColor = .lightGray
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        if let posterPath = movie.poster_path {
            getPoster(from: posterPath) { (imageData) in
                if let data = imageData {
                    DispatchQueue.main.async {
                        self.movieView.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        self.movieView.titleLabel.text = movie.title
        self.movieView.releaseDateLabel.text = "Released: \(movie.release_date ?? "unavailable")"
        if let average = movie.vote_average {
            self.movieView.voteLabel.text = "User score: \(average)"
        }
        self.movieView.overviewLabel.text = movie.overview

        scrollView.addSubview(movieView)
        view.addSubview(scrollView)
        
        installConstraints()
    }
        
    func installConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        movieView.translatesAutoresizingMaskIntoConstraints = false
        movieView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        movieView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height).isActive = true
        movieView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        movieView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        movieView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16).isActive = true
    }
}
