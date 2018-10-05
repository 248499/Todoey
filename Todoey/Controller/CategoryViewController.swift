//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Abdullah on 10/5/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var Categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
     
    }
    
    //MARK: - TableView Datasources Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = Categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destination.selectedCategory = Categories[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategory(){
        do{
            try context.save()
        }
        catch{
            print("error")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            Categories = try context.fetch(request)
        }
        catch{
            print("error: \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textfield.text!
            
            self.Categories.append(newCategory)
            
            self.saveCategory()
        }))
        
        alert.addTextField { (field) in
            textfield = field
            field.placeholder = "Add New Category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Delegate Methods
    
    
}
