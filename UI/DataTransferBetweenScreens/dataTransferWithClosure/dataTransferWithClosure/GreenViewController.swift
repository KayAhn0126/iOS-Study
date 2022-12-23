//
//  ViewController.swift
//  dataTransferWithClosure
//
//  Created by Kay on 2022/12/23.
//

import UIKit

class GreenViewController: UIViewController {
    
    @IBOutlet weak var sendButton: UIButton!
    
    var messageFromBlueVC: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func sendData(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "BlueViewController") as? BlueViewController else { return }
        
        vc.completioHandler = { [unowned self] msg in
            self.messageFromBlueVC = msg
            print(self.messageFromBlueVC)
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

