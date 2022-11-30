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
    @IBOutlet weak var addCommentButton: UIButton!
    
    // MARK: - Lifecycle
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: commentsWereSetNotificationName, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadViews), name: commentsWereSetNotificationName, object: nil)
        
        configureViews()
        updateViews()
        
        loadData()
    }

    // MARK: - Actions

    @IBAction func didPressAddCommentButton(_ sender: UIButton) {
        addComment()
    }
    
    // MARK: - Helpers
    
    func configureViews() {
        commentTextField.delegate = self
    }
    
    func updateViews() {
        addCommentButton.layer.cornerRadius = 4
        addCommentButton.clipsToBounds = true
    }
    
    @objc func reloadViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadData() {
        guard let post = post else {
            return
        }

        PostController.shared.fetchComments(for: post) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    break
                case .failure(let error):
                    self.presentAlert(title: "Error fetching comments", message: error.description)
                }
            }
        }
    }
    
    func addComment() {
        guard let post = post,
              let comment = commentTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !comment.isEmpty else { return }
        
        addCommentButton.isEnabled = false
        
        PostController.shared.addComment(to: post, text: comment) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let newIndexPath = IndexPath(row: post.comments.count - 1, section: PostDetailSection.commentsSection.rawValue)
                    self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                    self.commentTextField.text = ""
                    self.commentTextField.resignFirstResponder()
                    self.updatePostCell()
                case .failure(let error):
                    self.presentAlert(title: "Error creating comment", message: error.description)
                }
                
                self.addCommentButton.isEnabled = true
            }
        }
    }
    
    func updatePostCell() {
        let indexPath = IndexPath(row: 0, section: PostDetailSection.postSection.rawValue)
        guard let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell else { return }

        cell.updateCommentsLabel(with: post?.comments.count ?? 0)
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
            cell.delegate = self
            return cell
        case .commentsSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
            
            let comment = post.comments[indexPath.row]
            
            cell.textLabel?.text = comment.text
            cell.detailTextLabel?.text = "\(comment.timestamp.toString())"
            
            return cell
        case .none:
            return UITableViewCell()
        }
    }

}

extension PostDetailTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension PostDetailTableViewController: PostTableViewCellDelegate {
    
    func didPressShareButton(for post: Post) {
        let activity = UIActivityViewController(activityItems: [post.photo!, post.caption], applicationActivities: [])
        
        present(activity, animated: true)
    }
    
    func didReceiveSubscriptionError(_ error: PostError) {
        DispatchQueue.main.async {
            self.presentAlert(title: "Error subscribing to post", message: error.description)
        }
    }
    
}
