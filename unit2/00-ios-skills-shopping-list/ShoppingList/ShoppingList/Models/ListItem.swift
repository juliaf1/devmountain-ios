//
//  ListItem.swift
//  ShoppingList
//
//  Created by Julia Frederico on 25/10/22.
//

import Foundation

class ListItem: Codable {
    
    var name: String
    var checked: Bool = false
    var amount: String?
    
    init(name: String, amount: String? = nil) {
        self.name = name
        self.amount = amount
    }
    
}

extension ListItem: Equatable {
    
    static func ==(rhs: ListItem, lhs: ListItem) -> Bool {
        return rhs.name == lhs.name && rhs.checked == lhs.checked
    }

}
