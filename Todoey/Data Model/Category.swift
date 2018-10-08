//
//  Category.swift
//  Todoey
//
//  Created by Abdullah on 10/6/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    
    @objc dynamic var name: String = ""
    @objc dynamic var dateCreated: Date?
    let items = List<Item>()
}
