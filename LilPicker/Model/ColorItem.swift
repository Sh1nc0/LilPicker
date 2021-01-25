//
//  ColorItem.swift
//  LilPicker
//
//  Created by Romain Pipon on 25/01/2021.
//

import Foundation
import CoreData

public class ColorItem:NSManagedObject, Identifiable{
    @NSManaged public var createdAt: Date
    @NSManaged public var r: String
    @NSManaged public var g: String
    @NSManaged public var b: String
}

extension ColorItem{
    static func getAllColorItems() -> NSFetchRequest<ColorItem>{
        let request:NSFetchRequest<ColorItem> = ColorItem.fetchRequest() as! NSFetchRequest<ColorItem>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
