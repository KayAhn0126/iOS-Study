//
//  secondViewController.swift
//  ScreenTransition
//
//  Created by Kay on 2022/08/22.
//

import UIKit

class secondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func movePrevious(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
