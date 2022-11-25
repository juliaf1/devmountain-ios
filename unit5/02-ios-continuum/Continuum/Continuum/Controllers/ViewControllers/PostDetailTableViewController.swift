//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

enum PostDetailSection: Int, CaseIterable {
    case postSection
    case commentsSection
}

class PostDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var post: Post? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var commentTextField: UITextField!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions

    @IBAction func didPressAddCommentButton(_ sender: UIButton) {
        guard let post = post,
              let comment = commentTextField.text,
              !comment.isEmpty else { return }
        
        PostController.shared.addComment(to: post, text: comment) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let newIndexPath = IndexPath(row: post.comments.count - 1, section: PostDetailSection.commentsSection.rawValue)
                    self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                case .failure(let error):
                    // todo: display alert with error
                    print(error)
                }
            }
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return PostDetailSection.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch PostDetailSection(rawValue: section) {
        case .postSection:
            return 1
        case .commentsSection:
            return post?.comments.count ?? 0
        case .none:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = post else {
            return UITableViewCell()
        }

        
        switch PostDetailSection(rawValue: indexPath.section) {
        case .postSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
                return UITableViewCell()
            }
            
            cell.post = post
            return cell
        case .commentsSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
            
            let comment = post.comments[indexPath.row]
            
            cell.textLabel?.text = comment.text
            cell.detailTextLabel?.text = "\(comment.timestamp)"
            
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch PostDetailSection(rawValue: indexPath.section) {
        case .postSection:
            return 395
        case .commentsSection:
            return 60
        case .none:
            return 0
        }
    }

}
