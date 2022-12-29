//
//  AppDelegate.swift
//  Todoey
//
//  Created by Boughdiri Dorsaf on 26/12/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions")
        
        //To get the link to the local database file in mac
       /* print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)*/
        return true
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        //To save the database list
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        //The data thee we could save in it
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
// To save the context of the database
    func saveContext () {
        //Scrutch page
        //Blue print of saved database
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

