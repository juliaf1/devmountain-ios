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
    
    // MARK: - Outlets
    
    
    
    // MARK: - Helpers
    
    func updateView() {
        
    }
    
}
