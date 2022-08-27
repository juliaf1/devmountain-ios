//
//  PlanetTableViewController.swift
//  SolarSystem
//
//  Created by Julia Frederico on 27/08/22.
//

import UIKit

class PlanetTableViewController: UITableViewController {
    let planets = PlanetController.planets

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)

        let planet = planets[indexPath.row]
        
        cell.imageView?.image = UIImage(named: planet.imageName)
        cell.textLabel?.text = planet.name
        cell.detailTextLabel?.text = "Planet \(indexPath.row + 1)"

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
