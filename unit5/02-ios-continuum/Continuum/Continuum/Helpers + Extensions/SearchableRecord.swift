//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Julia Frederico on 29/11/22.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}
