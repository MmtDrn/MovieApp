//
//  Category.swift
//  MovieAppDesign
//
//  Created by MacBook on 19.03.2022.
//

import Foundation

class Category {
    
    var category_name:String?
    var category_id:String?
    
    init() {
    }
    init(category_name:String,category_id:String) {
        self.category_name = category_name
        self.category_id = category_id
    }
}
