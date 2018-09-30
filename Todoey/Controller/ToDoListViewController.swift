//
//  ViewController.swift
//  Todoey
//
//  Created by Abdullah on 9/26/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var myArray = [item]()
    
    let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(datafilepath!)
       
        /*
        let newItem = item()
        newItem.title = "Asp.net Developer"
        myArray.append(newItem)
        
        let newItem1 = item()
        newItem1.title = "Android Developer"
        myArray.append(newItem1)
        
        let newItem2 = item()
        newItem2.title = "IOS Developer"
        myArray.append(newItem2)
        
        let newItem3 = item()
        newItem3.title = "Java Developer"
        myArray.append(newItem3)
        */
        
        LoadItems()
        
        // Called NSUserDefault
        if let items = defaults.array(forKey: "TodoListArray") as? [item] {
            myArray = items
        }
    }
    
    // tableview datasource methods ***********
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // this cell below unsave .checkmark when drag cell
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        //print("select")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = myArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //ternery operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        //value = condition ? valueiftrue : valueiffalse
        
        /*if item.done == true {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        */
        
        return cell
    }

    // tableview delegate methods ***********
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(myArray[indexPath.row])")
        
        // method 1
        myArray[indexPath.row].done = !myArray[indexPath.row].done
        
        /*/  method 2
        /if myArray[indexPath.row].done == false {
            myArray[indexPath.row].done = true
        }
        else{
            myArray[indexPath.row].done = false
        }
        */
        
        /*if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        */
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func BtnPressed(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
            
            print("test")
            print(textfield.text!)
            
            if !(textfield.text?.isEmpty)! {
                
                let newItem = item()
                newItem.title = textfield.text!
                //newItem.done = true
                
                self.myArray.append(newItem)
                
               self.SaveItems()
            }
            
            
        }))
        
        alert.addTextField { (alerttextField) in
           
                alerttextField.placeholder = "Create New Item"
                textfield = alerttextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func SaveItems() {
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.myArray)
            try data.write(to: self.datafilepath!)
        }
        catch{
            print(error)
        }
        
        
        //self.defaults.set(self.myArray, forKey: "TodoListArray")
        
        self.tableView.reloadData()
    }
    
    
    func LoadItems() {
        
        if let data = try? Data(contentsOf: datafilepath!) {
            
        let decoder = PropertyListDecoder()
        
            do {
            myArray = try decoder.decode([item].self, from: data)
                
            }
            catch{
                print("error")
            }
        }
        
    }
    
    func myFunc(){
        
    }

}

