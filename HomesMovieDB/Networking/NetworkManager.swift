//
//  NetworkManager.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/9/20.
//

import UIKit

func getMovieList(by sort: String, completionHandler: @escaping ([Movie]) -> Void) {
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(sort)?api_key=\(TMDB_KEY)&language=en-US&page=1")!
    
    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
            print("Error fetching movie list: \(error)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Unexpected status code: \(String(describing: response))")
            return
        }
        
        if let data = data, let movies = try? JSONDecoder().decode(Movies.self, from: data) {
            completionHandler(movies.results)
        }
    })
    
    task.resume()
}

func getMovie(with id: Int, completionHandler: @escaping (Movie) -> Void) {
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(TMDB_KEY)")
    guard let validUrl = url else { return }
    
    let task = URLSession.shared.dataTask(with: validUrl, completionHandler: { (data, response, error) in
        if let error = error {
            print("Error fetching movie list: \(error)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Unexpected status code: \(String(describing: response))")
            return
        }
        
        if let data = data, let movie = try? JSONDecoder().decode(Movie.self, from: data) {
            completionHandler(movie)
        }
    })
    
    task.resume()
}

func getPoster(from posterPath: String, completionHandler: @escaping (_ data: Data?) -> ()) {
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error fetching image: \(error)")
            return
        } else {
            completionHandler(data)
        }
    }
    
    task.resume()
}
