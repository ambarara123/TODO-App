//
//  CategoryViewControllerTableViewController.swift
//  TODO App
//
//  Created by Ambar Kumar on 28/05/19.
//  Copyright © 2019 Ambar Kumar. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
                    .persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadItem()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        
        return cell
        
    }
        

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinstionVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinstionVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    @IBAction func addButtinPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let alertAction = UIAlertAction(title: "add Category", style: .default) { (alertAction) in
            print(textField.text!)
            let category = Category(context: self.context)
            category.name = textField.text!
            
            self.categories.append(category)
            
            self.saveItem()
            
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
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
          categories = try context.fetch(request)
        }catch{
            print("error while loading \(error)")
        }
        self.tableView.reloadData()
    }
    
    func saveItem(){
        do{
        try context.save()
        }catch{
            print("error while saving \(error)")
        }
        self.tableView.reloadData()
    }
}
