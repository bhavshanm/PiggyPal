//
//  Category.swift
//  PiggyLists
//
//  Created by Bhav Shan on 3/18/24.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
    
    
    
}
