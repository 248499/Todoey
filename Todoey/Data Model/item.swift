//
//  item.swift
//  Todoey
//
//  Created by Abdullah on 9/28/18.
//  Copyright © 2018 Abdullah. All rights reserved.
//

import Foundation

class item: Encodable , Decodable {
    
    var title: String = ""
    var done : Bool = false
}
