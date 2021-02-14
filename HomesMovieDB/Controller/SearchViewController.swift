//
//  SearchViewController.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 2/12/21.
//

import UIKit

class SearchViewController: UIViewController {
    let defaults: UserDefaults = UserDefaults.standard
    var movies: [Movie]?
    let movieTableView = UITableView()

    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.showsCancelButton = true
        bar.returnKeyType = .done
        return bar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lastSearchTitle = defaults.string(forKey: "LastSearchTitle"),
           let lastSearchResults = defaults.data(forKey: "LastSearchMovies") {
            title = lastSearchTitle
            do {
                let decoder = JSONDecoder()
                movies = try decoder.decode([Movie].self, from: lastSearchResults)
            } catch {
                print("error decoding movies: \(error)")
            }
        }
        
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isTranslucent = false

        searchBar.delegate = self
        
        view.addSubview(searchBar)
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
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
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

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchTerm = searchBar.text {
            title = "Searched: \(searchTerm)"
            getSearchResults(from: searchTerm.replacingOccurrences(of: " ", with: "%20"), completionHandler: { [weak self] (movies) in
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.movieTableView.reloadData()
                }
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(movies)
                    UserDefaults.standard.set(data, forKey: "LastSearchMovies")
                } catch {
                    print("error encoding movies: \(error)")
                }
            })
            
            defaults.set(title, forKey: "LastSearchTitle")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
