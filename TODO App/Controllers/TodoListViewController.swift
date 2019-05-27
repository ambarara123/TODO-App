//
//  ViewController.swift
//  TODO App
//
//  Created by Ambar Kumar on 24/05/19.
//  Copyright © 2019 Ambar Kumar. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadItems()

//        if let items = defaults.array(forKey: "TodoListArray") as? [ItemModel] {
//            itemArray = items
//        }
    }
    
    //MARK - Table view Datasources
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.complete == true ? .checkmark : .none
        

        return cell
    }
    
    //MARK - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].complete = !itemArray[indexPath.row].complete
        
//        context.delete(itemArray[indexPath.row])
//
//        itemArray.remove(at: indexPath.row)
        
        tableView.reloadData()
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new TODO Item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //when user clicks add item on alert button
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.complete = false
            self.itemArray.append(newItem)
            
           self.saveItems()
            
        }
        
        alert.addTextField(configurationHandler: { (alertTextField) in
            textField.placeholder = "Create new item"
            textField = alertTextField
        })
        
        alert.addAction(alertAction)
        present(alert, animated: true) {
            
        }
    }
    
    func saveItems(){
        do{
           try context.save()
        }catch{
            print(error)
        }
        
       self.tableView.reloadData()
    }
    
    
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
      itemArray = try context.fetch(request)
        }catch{
                print("\(error)")
            }
    }
    
    
    
}

