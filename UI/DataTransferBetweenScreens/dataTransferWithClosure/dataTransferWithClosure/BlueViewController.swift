//
//  BlueViewController.swift
//  dataTransferWithClosure
//
//  Created by Kay on 2022/12/23.
//

import UIKit

class BlueViewController: UIViewController {
    
    @IBOutlet weak var responseButton: UIButton!
    
    var completioHandler : ((String) -> (Void))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func responseToGreen(_ sender: Any) {
        completioHandler?("hello green~")
        self.navigationController?.popViewController(animated: true)
    }
}
