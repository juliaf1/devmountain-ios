//
//  PlanetTableViewController.swift
//  SolarSystem
//
//  Created by Julia Frederico on 27/08/22.
//

import UIKit

class PlanetTableViewController: UITableViewController {
    let planetController = PlanetController()
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planetController.planets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)

        let planet = planetController.planets[indexPath.row]
        
        cell.imageView?.image = UIImage(named: planet.imageName)
        cell.textLabel?.text = planet.name
        cell.detailTextLabel?.text = "Planet \(indexPath.row + 1)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))

        let image = UIImage(named: "solarSystem")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        headerView.addSubview(imageView)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tappedIndexPath = tableView.indexPathForSelectedRow else { return }

        let planet = planetController.planets[tappedIndexPath.row]
        if let destinationVC = segue.destination as? PlanetDetailViewController {
            destinationVC.planet = planet
        }
    }

}
