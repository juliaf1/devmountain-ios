//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    let controller = PostController.shared
    
    var posts: [Post] {
        return controller.posts
    }
    
    var resultsArray = [SearchableRecord]()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: postsWereSetNotificationName, object: nil)
    }
    
    // MARK: - Helpers
    
    @objc func updateViews() {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        let post = posts[indexPath.row]
        cell.post = post
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPostDetail",
              let destination = segue.destination as? PostDetailTableViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let post = posts[indexPath.row]
        destination.post = post
    }

}
