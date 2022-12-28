//
//  ViewController.swift
//  Todoey
//
//  Created by Boughdiri Dorsaf on 26/12/2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //to initialize table with an object: Item
    var itemArray = [Item]()
    
    //an interface to the users defaults databases
    //Local database in swift
    //let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(dataFilePath)
        
        //Loaded data from userDefaults
        /*if let items = defaults.array(forKey: "TodoListArray") as? [String] {
         itemArray = items
         }*/
        
        //To create database
        //userDomainMask == To save the file in the folder of user locations
        //First: to get the first item
        
        //To get data from nscoder database
        loadItems()
    }
    
    // Without data source protocol
    // To get the length of the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Called when we get the list of items
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // DequeueReusable to control the checkmark
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        /* ==> In this case the cell was get unchecked when the cell disappear from the screen
         let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell") */
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //To add the checkmark to the column that we clicked
        //Ternary Operator ==>
        //value = conditions ? valueIfTrue : valueIfFalse
        /* if itemArray[indexPath.row].done == true{
         cell.accessoryType = .checkmark
         }else{
         cell.accessoryType = .none
         }*/
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    // MARK - TableView Delegate Methods
    // Function called: To change the ui after we checked the checkmark
    // didselectRow: to cheeck if the row selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new item section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add New Todoey Item", message: "Enter a item description", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        //Closure when the text is added
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
        }
        
        // 3 - when user click ok button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            
            let textField = alert.textFields![0]
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //Add an item in the local database with forkey: to describe the key and the element to add in the dirst parenthesis
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
            
        }
        
        alert.addAction(action)
        
        // 4. Present the alert.
        present(alert, animated: true)
    }
    
    func saveItems() {
        //To encode data to save it
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print("Eroor in load data \(error)")
            }
        }
    }
    
    
    
}
