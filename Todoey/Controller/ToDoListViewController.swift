//
//  ViewController.swift
//  Todoey
//
//  Created by Abdullah on 9/26/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet{
            LoadItems()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //print(selectedCategory!)
        //print(x)
        //print(datafilepath!)
       
        /*
        let newItem = item()
        newItem.title = "Asp.net Developer"
        todoItems.append(newItem)
        
        let newItem1 = item()
        newItem1.title = "Android Developer"
        todoItems.append(newItem1)
        
        let newItem2 = item()
        newItem2.title = "IOS Developer"
        todoItems.append(newItem2)
        
        let newItem3 = item()
        newItem3.title = "Java Developer"
        todoItems.append(newItem3)
        */
        
        //LoadItems()
        
        // Called NSUserDefault
        //if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        //    todoItems = items
        //}
    }
    
    // tableview datasource methods ***********
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // this cell below unsave .checkmark when drag cell
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            //ternery operator
            cell.accessoryType = item.done ? .checkmark : .none
            
        }
        else{
            cell.textLabel?.text = "No Items Added"
        }
       
        
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
        
        if let item = todoItems?[indexPath.row] {
            do{
                try! realm.write {
                    item.done = !item.done
                    //for delete item
                    //realm.delete(item)
                }
            }
            catch{
                print("Error \(error)")
            }
        }
        
        tableView.reloadData()
        
        // to remove item from array ***
        //context.delete(todoItems[indexPath.row])
        //todoItems.remove(at: indexPath.row)
        
        // method 1
        //todoItems?[indexPath.row].done = !todoItems?[indexPath.row].done
        
        /*/  method 2
        /if todoItems[indexPath.row].done == false {
            todoItems[indexPath.row].done = true
        }
        else{
            todoItems[indexPath.row].done = false
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
                
                if let currentCategory = self.selectedCategory {
                    do{
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = textfield.text!
                            
                            let date = Date()
                            
                            newItem.dataCreated = date
                            currentCategory.items.append(newItem)
                        }
                   
                    }
                    catch{
                        print("error")
                    }
                }
                
               self.tableView.reloadData()
                //newItem.done = false
                

                //self.todoItems.append(newItem)
                
               //self.SaveItems()
            }
            
            
        }))
        
        alert.addTextField { (alerttextField) in
           
                alerttextField.placeholder = "Create New Item"
                textfield = alerttextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
//    func SaveItems() {
//
//
//        do{
//            try context.save()
//        }
//        catch{
//            print(error)
//        }
//
//
//        //self.defaults.set(self.todoItems, forKey: "TodoListArray")
//
//        self.tableView.reloadData()
//    }
    

    func LoadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        
        //let request :NSFetchRequest<Item> = Item.fetchRequest()
//        let CategoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [CategoryPredicate,additionalPredicate])
//        }
//        else{
//            request.predicate = CategoryPredicate
//        }
//        /*
//        let commandPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [CategoryPredicate,predicate!])
//
//        request.predicate = commandPredicate
//        */
//        do{
//        todoItems = try context.fetch(request)
//        }
//        catch{
//            print(error)
//        }
        self.tableView.reloadData()
    }

    func Delete(){
        //do{

        //try context.delete(todoItems[indexPath.row])
        //todoItems.remove(at: indexPath.row)
        //}
        //catch(){
            
        //}
        
        
    }

}
//MARK: - Search Bar Methods
extension ToDoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dataCreated", ascending: true)
        tableView.reloadData()
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        print(searchBar.text!)
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        //request.predicate = predicate
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        LoadItems(with: request,predicate: predicate)
//        //print(request.strin)
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

