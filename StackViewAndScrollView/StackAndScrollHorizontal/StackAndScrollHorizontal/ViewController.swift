//
//  ViewController.swift
//  StackAndScrollHorizontal
//
//  Created by Kay on 2022/08/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var horizontalStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        horizontalStackView.spacing = 10
    }

    @IBAction func addView(_ sender: UIButton) {
        let currentview = UIView()
        currentview.translatesAutoresizingMaskIntoConstraints = false
        currentview.backgroundColor = .orange
        currentview.isHidden = true
        currentview.widthAnchor.constraint(equalToConstant: 20).isActive = true
        horizontalStackView.addArrangedSubview(currentview)
        print(currentview.frame)
        
        UIView.animate(withDuration: 0.3) {
            currentview.isHidden = false
        }
    }
    
}

