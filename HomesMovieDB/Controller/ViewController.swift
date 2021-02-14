//
//  ViewController.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/9/20.
//

import UIKit

class ViewController: UIViewController {
    let defaults: UserDefaults = UserDefaults.standard
    let attributionVC = AttributionViewController()
    let searchVC = SearchViewController()
    var movies: [Movie]?
    let movieTableView = UITableView()
    
    let sortLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Sort: "
        return label
    }()
    
    let sortControl: UISegmentedControl = {
        let options = ["Top Rated", "Popular"]
        let segmentedControl = UISegmentedControl(items: options)
        segmentedControl.backgroundColor = .systemBackground
        segmentedControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Show previous view
        if let titleFromDefaults = defaults.string(forKey: "Title"),
           let sortFromDefaults = defaults.string(forKey: "Sort") {
            title = titleFromDefaults
            sortMovies(by: sortFromDefaults)
            sortControl.selectedSegmentIndex = defaults.integer(forKey: "SortControlIndex")
        } else {
            title = "Top Rated Movies"
            sortMovies(by: "top_rated")
            sortControl.selectedSegmentIndex = 0
        }
        
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isTranslucent = false
        let infoButton = UIBarButtonItem(title: "ℹ︎", style: .plain, target: self, action: #selector(showAttribution))
        navigationItem.rightBarButtonItem = infoButton
        let searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(showSearch))
        navigationItem.leftBarButtonItem = searchButton

        view.addSubview(sortLabel)
        view.addSubview(sortControl)
        configureTableView()
        installConstraints()
    }
    
    func configureTableView() {
        view.addSubview(movieTableView)
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = 140
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
    }
    
    func installConstraints() {
        sortLabel.translatesAutoresizingMaskIntoConstraints = false
        sortLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        sortLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        sortLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sortLabel.heightAnchor.constraint(equalTo: sortControl.heightAnchor).isActive = true
        
        sortControl.translatesAutoresizingMaskIntoConstraints = false
        sortControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        sortControl.leadingAnchor.constraint(equalTo: sortLabel.trailingAnchor, constant: 16).isActive = true
        sortControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieTableView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: 8).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func sortMovies(by order: String) {
        getMovieList(by: order) { [weak self] (movies) in
            self?.movies = movies
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
        switch sortControl.selectedSegmentIndex {
        case 0:
            sortMovies(by: "top_rated")
            title = "Top Rated Movies"
            defaults.set("Top Rated Movies", forKey: "Title")
            defaults.set("top_rated", forKey: "Sort")
            defaults.set(0, forKey: "SortControlIndex")
        default:
            sortMovies(by: "popular")
            title = "Popular Movies"
            defaults.set("Popular Movies", forKey: "Title")
            defaults.set("popular", forKey: "Sort")
            defaults.set(1, forKey: "SortControlIndex")
        }
    }
    
    @objc func showAttribution() {
        self.navigationController?.pushViewController(attributionVC, animated: false)
    }
    
    @objc func showSearch() {
        self.navigationController?.pushViewController(searchVC, animated: false)
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

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            title = "Searched: \(searchTerm)"
            getSearchResults(from: searchTerm.replacingOccurrences(of: " ", with: "%20"), completionHandler: { [weak self] (movies) in
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.movieTableView.reloadData()
                }
            })
        }
    }
}
