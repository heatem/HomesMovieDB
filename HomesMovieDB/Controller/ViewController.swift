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
    
    let sortTypePicker: UISegmentedControl = {
        let sortOptions = ["Top Rated", "Popular"]
        let segmentedControl = UISegmentedControl(items: sortOptions)
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top Rated Movies"
        self.navigationController?.navigationBar.isTranslucent = false
        let infoButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showAttribution))
        navigationItem.rightBarButtonItem = infoButton

        configureTableView()
        installConstraints()
        
        getMovieList(by: "top_rated") { [weak self] (movies) in
            self?.movies = movies
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(sortTypePicker)
        view.addSubview(movieTableView)
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = 140
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
    }
    
    func installConstraints() {
        sortTypePicker.translatesAutoresizingMaskIntoConstraints = false
        sortTypePicker.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sortTypePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sortTypePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // TODO: look at Pinning function at minute 8 in https://www.youtube.com/watch?v=bXHinfFMkFw
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieTableView.topAnchor.constraint(equalTo: sortTypePicker.topAnchor).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func showAttribution() {
        self.navigationController?.pushViewController(attributionVC, animated: false)
//        self.navigationController?.pushViewController(homeView, animated: true)
        // navigationVC = UINavigationController(rootViewController: AttributionViewController())
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let movie = movies?[indexPath.row] {
            let movieVC = MovieViewController()
            movieVC.title = movie.title
            movieVC.movie = movie
            navigationController?.pushViewController(movieVC, animated: true)
        }
    }
    
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
