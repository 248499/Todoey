//
//  ViewController.swift
//  Todoey
//
//  Created by Abdullah on 9/26/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var myArray = [Item]()
    
    var selectedCategory: Category? {
        didSet{
            LoadItems()
        }
    }
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        print(selectedCategory!)
        //print(x)
        //print(datafilepath!)
       
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
        
        //LoadItems()
        
        // Called NSUserDefault
        //if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        //    myArray = items
        //}
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
        
        // to remove item from array ***
        //context.delete(myArray[indexPath.row])
        //myArray.remove(at: indexPath.row)
        
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
        
        //tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func BtnPressed(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
            
            print("test")
            print(textfield.text!)
            
            if !(textfield.text?.isEmpty)! {
                
                let newItem = Item(context: self.context)
                newItem.title = textfield.text!
                newItem.done = false
                newItem.parentCategory = self.selectedCategory
                
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
        
        
        do{
            try context.save()
        }
        catch{
            print(error)
        }
        
        
        //self.defaults.set(self.myArray, forKey: "TodoListArray")
        
        self.tableView.reloadData()
    }
    

    func LoadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        //let request :NSFetchRequest<Item> = Item.fetchRequest()
        let CategoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [CategoryPredicate,additionalPredicate])
        }
        else{
            request.predicate = CategoryPredicate
        }
        /*
        let commandPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [CategoryPredicate,predicate!])
        
        request.predicate = commandPredicate
        */
        do{
        myArray = try context.fetch(request)
        }
        catch{
            print(error)
        }
        self.tableView.reloadData()
    }

    func Delete(){
        //do{

        //try context.delete(myArray[indexPath.row])
        //myArray.remove(at: indexPath.row)
        //}
        //catch(){
            
        //}
        
        
    }

}
//MARK: - Search Bar Methods
extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        print(searchBar.text!)
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        //request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        LoadItems(with: request,predicate: predicate)
        //print(request.strin)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            LoadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
 
        }
    }
    
    
}

