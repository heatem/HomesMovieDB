//
//  Movie.swift
//  HomesMovieDB
//
//  Created by Heather Mason on 12/9/20.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String?
    let overview: String?
    let release_date: String?
    let poster_path: String?
    let vote_average: Double?
    let isSaved: Bool = false
}
