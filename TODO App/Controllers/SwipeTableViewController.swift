//
//  SwipeTableViewController.swift
//  TODO App
//
//  Created by Ambar Kumar on 30/05/19.
//  Copyright © 2019 Ambar Kumar. All rights reserved.
//

import UIKit
import SwipeCellKit
class SwipeTableViewController: UITableViewController,SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    tableView.rowHeight = 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        tableView.separatorStyle = .none
        return cell
    }

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else{return nil}
        
        print()
        
        let deleteAction = SwipeAction(style: .destructive, title: "delete") { (action, indexPath) in
            
            self.updateModel(at: indexPath)
        }
        
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
    func updateModel(at indexPath : IndexPath) {
       
        
    }

}
