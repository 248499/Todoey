//
//  Data.swift
//  Todoey
//
//  Created by Abdullah on 10/5/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var age:Int = 0
    
}
