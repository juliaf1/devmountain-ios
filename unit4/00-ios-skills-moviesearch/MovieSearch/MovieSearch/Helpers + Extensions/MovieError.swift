//
//  MovieError.swift
//  MovieSearch
//
//  Created by Julia Frederico on 17/11/22.
//

import Foundation

enum MovieError: LocalizedError {

    case invalidURL
    case noData
    case invalidImage
    case thrownError(Error)

}
