//
//  PlanetController.swift
//  SolarSystem
//
//  Created by Julia Frederico on 27/08/22.
//

import Foundation

class PlanetController {
    static var planets: [Planet] {
        let mercury = Planet("Mercury", imageName: "mercury", diameter: 4880, dayLength: 87.969, maxMillionKMsFromSun: 43.0)
        let venus = Planet("Venus", imageName: "venus", diameter: 12104, dayLength: 2802, maxMillionKMsFromSun: 108.2)
        let earth = Planet("Earth", imageName: "earth", diameter: 12756, dayLength: 24, maxMillionKMsFromSun: 149.6)
        let mars = Planet("Mars", imageName: "mars", diameter: 6792, dayLength: 24.7, maxMillionKMsFromSun: 227.9)
        let jupiter = Planet("Jupiter", imageName: "jupiter", diameter: 42984, dayLength: 9.9, maxMillionKMsFromSun: 778.6)
        let saturn = Planet("Saturn", imageName: "saturn", diameter: 120536, dayLength: 10.7, maxMillionKMsFromSun: 1433.5)
        let uranus = Planet("Uranus", imageName: "uranus", diameter: 51118, dayLength: 17.2, maxMillionKMsFromSun: 2872.5)
        let neptune = Planet("Neptune", imageName: "neptune", diameter: 49528, dayLength: 16.1, maxMillionKMsFromSun: 4495.1)
        let pluto = Planet("Pluto", imageName: "pluto", diameter: 2370, dayLength: 153.3, maxMillionKMsFromSun: 5906.4)
        
        return [mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto]
    }
}
