//
//  Planet.swift
//  SolarSystem
//
//  Created by Julia Frederico on 27/08/22.
//

import Foundation

class Planet {
    let name: String
    let imageName: String
    let diameter: Int
    let dayLength: Double
    let maxMillionKMsFromSun: Double
    
    init(_ name: String, imageName: String, diameter: Int, dayLength: Double, maxMillionKMsFromSun: Double) {
        self.name = name
        self.imageName = imageName
        self.diameter = diameter
        self.dayLength = dayLength
        self.maxMillionKMsFromSun = maxMillionKMsFromSun
    }
}

extension Planet: Equatable {
    static func ==(lhs: Planet, rhs: Planet) -> Bool {
        lhs.name == rhs.name && lhs.imageName == rhs.imageName && lhs.diameter == rhs.diameter && lhs.dayLength == rhs.dayLength && lhs.maxMillionKMsFromSun == rhs.maxMillionKMsFromSun
    }
}
