//
//  ItemTableViewController.swift
//  shoppinglist-ios
//
//  Created by NhutHuynh on 3/9/21.
//

import UIKit

class ItemTableViewController: BaseTableViewController {
    
    var items: [Item] = [Item].load() {
        didSet {
            items.save()
        }
    }
    
    @IBAction func didSelectAdd(_ sender: UIBarButtonItem) {
        
        requestInput(title: "New shopping list item", message: "Enter item to add to the shopping list:", handler: {
            
            itemName in
            
            let itemCount = self.items.count
            let item      = Item(name: itemName)
            
            self.items.append(item)
            self.tableView.insertRows(at: [IndexPath(row: itemCount, section: 0)], with: .top)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shopping List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItems?.append(editButtonItem)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.accessoryType   = item.isChecked ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = items.remove(at: sourceIndexPath.row)
        
        items.insert(item, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        items[indexPath.row] = items[indexPath.row].toggelCheck()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
