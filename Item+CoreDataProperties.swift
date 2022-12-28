//
//  Item+CoreDataProperties.swift
//  Todoey
//
//  Created by Boughdiri Dorsaf on 28/12/2022.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }


}

extension Item : Identifiable {

}
