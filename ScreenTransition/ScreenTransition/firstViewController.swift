//
//  ViewController.swift
//  ScreenTransition
//
//  Created by Kay on 2022/08/22.
//

import UIKit

class firstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveNext(_ sender: UIButton) {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "secondViewController")
        nextVC.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(nextVC, animated: true)
    }
    
}

