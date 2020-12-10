//
//  NetworkManager.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/9/20.
//

import UIKit

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

/*
 func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
     let session = URLSession.shared
     let url = URL(string: image_url)
         
     let dataTask = session.dataTask(with: url!) { (data, response, error) in
         if error != nil {
             print("Error fetching the image! 😢")
             completionHandler(nil)
         } else {
             completionHandler(data)
         }
     }
         
     dataTask.resume()
 }
 */
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

//
//
//    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//        if let error = error {
//            print("Error fetching image: \(error)")
//            return
//        }
//
//        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//            // TODO: Handle networking error to show something useful
//            print("Unexpected status code: \(String(describing: response))")
//            return
//        }
//
//        if let data = data {
//            print(data)
//            completionHandler()
//        }
//    })
//
//    task.resume()
//}
