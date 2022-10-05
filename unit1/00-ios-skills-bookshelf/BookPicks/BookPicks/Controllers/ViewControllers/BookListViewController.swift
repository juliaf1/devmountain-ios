//
//  BookListViewController.swift
//  BookPicks
//
//  Created by Julia Frederico on 05/10/22.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var bookTableView: UITableView!

    // MARK: - Properties

    let books = BookController().books

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)

        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author
        cell.imageView?.image = UIImage(named: book.photo)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBookDetailVC" {
            guard let indexPath = bookTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? BookDetailViewController else { return }
            
            let bookToSend = books[indexPath.row]
            destination.book = bookToSend
        }
    }

}
