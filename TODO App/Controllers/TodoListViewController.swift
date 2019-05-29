//
//  ViewController.swift
//  TODO App
//
//  Created by Ambar Kumar on 24/05/19.
//  Copyright © 2019 Ambar Kumar. All rights reserved.
//

import UIKit
import RealmSwift
class TodoListViewController: UITableViewController{
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // loadItems()

//        if let items = defaults.array(forKey: "TodoListArray") as? [ItemModel] {
//            todoItems = items
//        }
    }
    
    //MARK - Table view Datasources
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.complete == true ? .checkmark : .none
        }else{
            cell.textLabel?.text = "no Item added"
        }
        
      
        return cell
    }
    
    //MARK - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            do{
            try realm.write {
                item.complete = !item.complete
            }
            }catch{
                print("error saving done status \(error)")
            }
            
        }
        
//        todoItems?[indexPath.row].complete = !todoItems?[indexPath.row].complete
//
        tableView.reloadData()
//
//        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new TODO Item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //when user clicks add item on alert button
            if let currentCategery = self.selectedCategory{
                
                do{
                   try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategery.items.append(newItem)
                    }
                }catch{
                    print("error saving items \(error)")
                }
   
            }
            
            self.tableView.reloadData()
     
        }
        
        alert.addTextField(configurationHandler: { (alertTextField) in
            textField.placeholder = "Create new item"
            textField = alertTextField
        })
        
        alert.addAction(alertAction)
        present(alert, animated: true) {
            
        }
    }
 
    
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
}

extension TodoListViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
    

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchBar.text!.count)")
        if searchBar.text!.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

