//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Julia Frederico on 17/11/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var movie: Movie? {
        didSet {
            updateView()
        }
    }
    
    var moviePoster: UIImage? {
        didSet {
            posterImageView.image = moviePoster
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    
    // MARK: - Helpers
    
    func updateView() {
        guard let movie = movie else {
            return
        }

        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "Rating: \(movie.rating)"
        movieOverviewLabel.text = movie.overview
    }
    
}
