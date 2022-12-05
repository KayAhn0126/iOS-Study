//
//  ViewController.swift
//  SettingAttributesOfLabelThroughExtensions
//
//  Created by Kay on 2022/12/05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = "Hello World!"
        myLabel.bold("Hello")
        /*
        myLabel.attributedText = NSMutableAttributedString()
            .regular(string: "H", fontSize: 20)
            .bold(string: "ello", fontSize: 15)
            .orangeHighlight("W")
            .blackHighlight("orld!")
            .underlined("orld!")
         */
    }
}

