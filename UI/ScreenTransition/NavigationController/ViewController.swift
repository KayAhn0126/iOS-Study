//
//  ViewController.swift
//  NavigationController
//
//  Created by Kay on 2022/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveNext(_ sender: UIBarButtonItem) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") else {
            return
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
        // pushViewController는 호출하는 대상이 내비게이션 컨트롤러.
        // self.navigationController는 현재의 뷰 컨트롤러에 연결된 내비게이션 컨트롤러를 가리키는 것으로, 만약 뷰 컨트롤러에 내비게이션 컨트롤러가 연결되어 있지 않을 경우 nil 반환.
    }
}

