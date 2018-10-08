//
//  Item.swift
//  Todoey
//
//  Created by Abdullah on 10/6/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dataCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
