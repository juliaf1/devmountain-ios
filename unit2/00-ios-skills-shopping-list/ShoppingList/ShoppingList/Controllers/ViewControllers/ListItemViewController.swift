//
//  ListItemViewController.swift
//  ShoppingList
//
//  Created by Julia Frederico on 25/10/22.
//

import UIKit

class ListItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum Section: Int {
        case unchecked
        case checked
    }
    
    // MARK: - Properties and outlets
    
    let listController = ListItemController.shared
    
    var uncheckedItems: [ListItem] {
        listController.items.filter { item in !item.checked }
    }
    
    var checkedItems: [ListItem] {
        listController.items.filter { item in item.checked }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section(rawValue: section) {
        case .unchecked:
            return "Items to buy"
        case .checked:
            return "Items bought"
        case .none:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .unchecked:
            return uncheckedItems.count
        case .checked:
            return checkedItems.count
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath) as? ListItemTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch Section(rawValue: indexPath.section) {
        case .unchecked:
            let item = uncheckedItems[indexPath.row]
            cell.updateView(for: item)
        case .checked:
            let item = checkedItems[indexPath.row]
            cell.updateView(for: item)
        case .none:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            switch Section(rawValue: indexPath.section) {
            case .unchecked:
                let item = uncheckedItems[indexPath.row]
                listController.delete(item)
            case .checked:
                let item = checkedItems[indexPath.row]
                listController.delete(item)
            case .none:
                break
            }

            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            break
        case .none:
            break
        default:
            break
        }
    }

}

extension ListItemViewController: ListItemCellDelegate {
    
    func didToggleCheck(for cell: ListItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        switch Section(rawValue: indexPath.section) {
        case .unchecked:
            let item = uncheckedItems[indexPath.row]
            listController.toggleCheck(of: item)
        case .checked:
            let item = checkedItems[indexPath.row]
            listController.toggleCheck(of: item)
        case .none:
            break
        }

        tableView.reloadData()
    }
    
}

extension ListItemViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
