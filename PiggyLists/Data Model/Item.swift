//
//  Item.swift
//  PiggyLists
//
//  Created by Bhav Shan on 3/18/24.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    
    
}
