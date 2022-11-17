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
            updateViews()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    
    // MARK: - Helpers
    
    func updateViews() {
        guard let movie = movie else {
            return
        }

        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "Rating: \(movie.rating)"
        movieOverviewLabel.text = movie.overview
        
        fetchAndUpdatePosterImage(for: movie)
    }
    
    func fetchAndUpdatePosterImage(for movie: Movie) {
        guard let posterURL = movie.posterURL else {
            return
        }

        MovieController.fetchImage(for: posterURL) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.posterImageView.image = image
                case .failure(let error):
                    print("Error fetching image for \(movie)", error)
                }
            }
        }
    }
    
}
