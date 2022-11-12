//
//  ViewController.swift
//  StackAndScroll
//
//  Created by Kay on 2022/08/03.
//

import UIKit

class ViewController: UIViewController {
    
    var viewSize = 15
    
    @IBOutlet weak var verticalView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalView.spacing = 10
    }

    @IBAction func addView(_ sender: UIButton) {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.heightAnchor.constraint(equalToConstant: CGFloat(viewSize)).isActive = true
        verticalView.addArrangedSubview(view)
        
        UIView.animate(withDuration: 0.3) {
            view.isHidden = false
        } completion: { (_) in
            let label = UILabel(frame: view.bounds)
            label.numberOfLines = 0
            label.textAlignment = .center
            label.text = "CGFloat: \(self.viewSize) point(s)"
            label.textColor = .orange
            view.addSubview(label)
            self.viewSize = self.viewSize + 5
        }
    }
    
    @IBAction func removeView(_ sender: UIButton) {
        guard let last = verticalView.arrangedSubviews.last else { return }
        UIView.animate(withDuration: 0.3) {
            last.isHidden = true
        } completion: { (_) in
            self.verticalView.removeArrangedSubview(last)
            self.viewSize = self.viewSize - 5
        }   
    }
}

