//
//  MovieSearchViewController.swift
//  MovieSearch
//
//  Created by Julia Frederico on 17/11/22.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helpers

}

extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
