//
//  BookDetailViewController.swift
//  BookPicks
//
//  Created by Julia Frederico on 05/10/22.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - Properties

    var book: Book?
    
    // MARK: - Outlets
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Helpers
    func setUpView() {
        guard let book = book else { return }
        coverImage.image = UIImage(named: book.photo)
        titleLabel.text = book.title
        ratingLabel.text = "\(book.rating)/5"
        releaseDateLabel.text = book.formattedDate
        descriptionLabel.text = book.description
        
    }
}
