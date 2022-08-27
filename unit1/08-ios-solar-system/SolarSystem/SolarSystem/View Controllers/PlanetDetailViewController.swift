//
//  PlanetDetailViewController.swift
//  SolarSystem
//
//  Created by Julia Frederico on 27/08/22.
//

import UIKit

class PlanetDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavbar()
    }
    
    func setUpNavbar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Solar System"

        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
