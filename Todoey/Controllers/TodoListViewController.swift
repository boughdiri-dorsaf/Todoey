//
//  ViewController.swift
//  Todoey
//
//  Created by Boughdiri Dorsaf on 26/12/2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    
    //an interface to the users defaults databases
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }*/
        
        let newItem1 = Item()
        newItem1.title = "Good Mornning"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Good "
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Ok !"
        itemArray.append(newItem3)
        
    }
    
    //Without data source protocol
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
   
    // Called when we get the list of items
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = itemArray[indexPath.row].title
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        /* ==> In this case the cell was get unchecked when the cell disappear from the screen
               let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell") */
        cell.textLabel?.text = row
        
        //To add the checkmark to the column that we clicked
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    //Function called: To change the ui after we checked the checkmark
    //didselectRow: to cheeck if the row selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else {
            itemArray[indexPath.row].done = false
        }
        
        tableView.reloadData()
        
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
            
            print(textField.text!)
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            //Add an item in the local database with forkey: to describe the key and the element to add in the dirst parenthesis
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)

        // 4. Present the alert.
        present(alert, animated: true)
    }
    
}




