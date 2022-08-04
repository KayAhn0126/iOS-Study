//
//  ViewController.swift
//  StackAndScroll
//
//  Created by Kay on 2022/08/03.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var verticalView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        verticalView.spacing = 30
    }

    @IBAction func addView(_ sender: UIButton) {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        verticalView.addArrangedSubview(view)
        UIView.animate(withDuration: 0.3) {
            view.isHidden = false
        }
    }
    
    @IBAction func removeView(_ sender: UIButton) {
        
        
    }
}

