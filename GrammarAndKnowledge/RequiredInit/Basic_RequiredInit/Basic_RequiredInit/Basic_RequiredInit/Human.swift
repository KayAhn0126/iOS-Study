//
//  Human.swift
//  Basic_RequiredInit
//
//  Created by Kay on 2022/12/18.
//

import Foundation


class Human {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

class Student: Human {
    var grade: Int
    
    init(name: String, grade: Int) {
        self.grade = grade
        super.init(name: name)
    }
    
    required init(name: String) {
        self.grade = 5
        super.init(name: name)
    }
}
