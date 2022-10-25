//
//  ListItemViewController.swift
//  ShoppingList
//
//  Created by Julia Frederico on 25/10/22.
//

import UIKit

class ListItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties and outlets
    
    let listController = ListItemController.shared
    
    var items: [ListItem] {
        listController.items
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listItemNameLabel: UITextField!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listController.loadFromPersistentStorage()
        
        listItemNameLabel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    
    @IBAction func didPressSaveItemButton(_ sender: UIButton) {
        guard let name = listItemNameLabel.text,
              !name.isEmpty else { return }

        listItemNameLabel.text = ""
        listController.add(ListItem(name: name))
        tableView.reloadData()
    }

    // MARK: - Table view datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath) as? ListItemTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self

        let item = items[indexPath.row]
        cell.updateView(for: item)
        
        return cell
    }

}

extension ListItemViewController: ListItemCellDelegate {
    
    func didToggleCheck(for cell: ListItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = items[indexPath.row]
        listController.toggleCheck(of: item)
        tableView.reloadData()
    }
    
}

extension ListItemViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
