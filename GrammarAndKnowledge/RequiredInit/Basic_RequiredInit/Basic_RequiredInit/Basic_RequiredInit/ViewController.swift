//
//  ViewController.swift
//  Basic_RequiredInit
//
//  Created by Kay on 2022/12/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var x = Student(name: "Kay")
        print(x.grade)
        print(x.name)
    }
}
