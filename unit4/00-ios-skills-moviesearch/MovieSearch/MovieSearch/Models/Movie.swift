//
//  Movie.swift
//  MovieSearch
//
//  Created by Julia Frederico on 17/11/22.
//

import Foundation

struct Movie: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case language = "original_language"
        case genres = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case votes = "vote_count"
        case voteAverage = "vote_average"
    }

    // MARK: - Stored Properties

    // Details
    let id: Int
    let title: String
    let overview: String
    let language: String
    let genres: [Int]
    
    // Images Paths
    let posterPath: String
    let backdropPath: String

    // Voting Details
    var votes: Int
    var voteAverage: Double

    // MARK: - Computed Properties

    var posterURL: URL? {
        guard let baseURL = URL(string: Strings.imageBaseURL) else { return nil }
        return baseURL.appendingPathComponent(posterPath)
    }
    
    var backdropURL: URL? {
        guard let baseURL = URL(string: Strings.imageBaseURL) else { return nil }
        return baseURL.appendingPathComponent(backdropPath)
    }
    
}

struct MovieSearchResponse: Decodable {
    let results: [Movie]
}
