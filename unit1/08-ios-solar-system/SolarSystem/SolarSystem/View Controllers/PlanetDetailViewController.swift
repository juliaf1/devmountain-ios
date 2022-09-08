//
//  PlanetDetailViewController.swift
//  SolarSystem
//
//  Created by Julia Frederico on 27/08/22.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    var planet: Planet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavbar()
        updateViews()
    }
    
    func updateViews() {
        guard let planet = planet else { return }
        
        planetName.text = planet.name
        planetImage.image = UIImage(named: planet.imageName)
        planetDiameter.text = "\(planet.diameter)km"
        planetDistance.text = "\(planet.maxMillionKMsFromSun)km^6"
        planetDayLength.text = "\(planet.dayLength)"
    }
    
    func setUpNavbar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Solar System"

        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var planetDiameter: UILabel!
    @IBOutlet weak var planetDistance: UILabel!
    @IBOutlet weak var planetDayLength: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
