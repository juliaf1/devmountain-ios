//
//  MovieSearchViewController.swift
//  MovieSearch
//
//  Created by Julia Frederico on 17/11/22.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    var movies: [Movie] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieListTableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchBar.delegate = self
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
    }
    
    // MARK: - Helpers

}

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
    
        let movie = movies[indexPath.row]
        cell.movie = movie
        
        return cell
    }
    
}
