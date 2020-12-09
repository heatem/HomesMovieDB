//
//  ViewController.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/9/20.
//

import UIKit

class ViewController: UIViewController {
    let attributionVC = AttributionViewController()
    var movies: [Movie]?
    let movieTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Top Rated Movies"
        self.view.backgroundColor = UIColor.red
        self.navigationController?.navigationBar.isTranslucent = false
        // TODO: Add nav bar button for attribution view
        // TODO: Add list view
        configureTableView()
        installConstraints()
        
        getMovies() { [weak self] (movies) in
            self?.movies = movies
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(movieTableView)
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = 140
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
    }
    
    func installConstraints() {
        // TODO: look at Pinning function at minute 8 in https://www.youtube.com/watch?v=bXHinfFMkFw
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        if let moviesList = movies {
            let movie = moviesList[indexPath.row]
            cell.set(movie: movie)
        }
        return cell
    }
}
