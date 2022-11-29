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
    
    var isSearching = false
    
    let controller = PostController.shared
    
    var posts: [SearchableRecord] {
        return isSearching ? resultsArray : controller.posts
    }
    
    var resultsArray = [SearchableRecord]()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: postsWereSetNotificationName, object: nil)
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultsArray = controller.posts
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell,
              let post = posts[indexPath.row] as? Post else {
            return UITableViewCell()
        }
        
        cell.post = post
        cell.delegate = self
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPostDetail",
              let destination = segue.destination as? PostDetailTableViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let post = posts[indexPath.row] as? Post else { return }

        destination.post = post
    }

}

extension PostListTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            resultsArray = controller.posts
        } else {
            resultsArray = controller.posts.filter { $0.matches(searchTerm: searchText) }
        }

        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        resultsArray = controller.posts
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
}

extension PostListTableViewController: PostTableViewCellDelegate {
    
    func didPressShareButton(for post: Post) {
        let activity = UIActivityViewController(activityItems: [post.photo!, post.caption], applicationActivities: [])
        
        present(activity, animated: true)
    }
    
}
