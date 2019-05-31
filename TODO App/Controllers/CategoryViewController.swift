//
//  CategoryViewControllerTableViewController.swift
//  TODO App
//
//  Created by Ambar Kumar on 28/05/19.
//  Copyright © 2019 Ambar Kumar. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
   
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItem()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Added"
        
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].hexColor ?? "#28AAC0")
        
        return cell
        
    }
        

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinstionVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinstionVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    @IBAction func addButtinPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let alertAction = UIAlertAction(title: "add Category", style: .default) { (alertAction) in
            print(textField.text!)
            let category = Category()
            category.name = textField.text!
            category.hexColor = UIColor.randomFlat.hexValue()
            
            self.saveItem(category: category)
            
        }
        alert.addTextField { (uiTextField) in
            uiTextField.placeholder = "Name of category"
            textField = uiTextField
        }
        alert.addAction(alertAction)
        
        
        present(alert,animated: true){
            
        }
    }
    
    func loadItem(){
        categories = realm.objects(Category.self)
        
        self.tableView.reloadData()
    }
    
    func saveItem(category : Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("error while saving \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK:- delete action
    
    override func updateModel(at indexPath : IndexPath) {
        if let current = self.categories?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(current)
                }
            }catch{
                print("error in deleting \(error)")
            }
        }
        
        

    }
}

