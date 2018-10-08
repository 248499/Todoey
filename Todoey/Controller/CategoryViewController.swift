//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Abdullah on 10/5/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    var realm = try! Realm()
    
    var Categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
     
    }
    
    //MARK: - TableView Datasources Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // called coalescing operator
        return Categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = Categories?[indexPath.row].name ?? "No Categories Added yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destination.selectedCategory = Categories?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("error")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        Categories = realm.objects(Category.self).sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            
            let newCategory = Category()
            
            newCategory.name = textfield.text!
            newCategory.dateCreated = Date()
            // we dont need for append in realm because it updated container ...
            //self.Categories.append(newCategory)
            
            self.save(category: newCategory)
        }))
        
        alert.addTextField { (field) in
            textfield = field
            field.placeholder = "Add New Category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Delegate Methods
    
    
}
