//
//  ViewController.swift
//  Todoey
//
//  Created by Abdullah on 9/26/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var myArray = ["Asp.net Developer","Android Developer","IOS Developer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // tableview datasource methods ***********
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = myArray[indexPath.row]
        
        return cell
    }

    // tableview delegate methods ***********
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(myArray[indexPath.row])")
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func BtnPressed(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
            
            print("test")
            print(textfield.text)
            
            if !(textfield.text?.isEmpty)! {
                self.myArray.append(textfield.text!)
                self.tableView.reloadData()
            }
            
            
        }))
        
        alert.addTextField { (alerttextField) in
           
                alerttextField.placeholder = "Create New Item"
                textfield = alerttextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func myFunc(){
        
    }

}

