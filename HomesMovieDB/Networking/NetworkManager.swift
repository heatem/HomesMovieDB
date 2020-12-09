//
//  NetworkManager.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/9/20.
//

import Foundation

func getMovies(completionHandler: @escaping ([Movie]) -> Void) {
    let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(TMDB_KEY)&language=en-US&page=1")!
    
    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
            print("Error fetching movie list: \(error)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            // TODO: Handle networking error to show something useful
            print("Unexpected status code: \(String(describing: response))")
            return
        }
        
        if let data = data, let movies = try? JSONDecoder().decode(Movies.self, from: data) {
            completionHandler(movies.results)
        }
    })
    
    task.resume()
}
