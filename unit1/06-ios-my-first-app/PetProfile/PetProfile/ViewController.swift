//
//  ViewController.swift
//  PetProfile
//
//  Created by Julia Frederico on 26/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        petSetup()
    }
    
    func petSetup() {
        nameLabel.text = "Peppa"
        titleLabel.text = "Dinousaur in dog disguise, Trouble maker, 10 Times Fastest Eater Champion"
        ageLabel.text = "1 year"
        imageView.image = UIImage(named: "peppa")
        bioLabel.text = "Peppa is a one year old Golden Retriever pup who loves eating, jumping, playing, cuddling and destroying all types of objects, especially cloths. She enjoys bananas, coconuts, water, water playing, pools, sand, trees and people. But don't let her fool you, she has gigantic dinousaur paws."
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
}

