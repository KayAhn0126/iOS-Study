//
//  ViewController.swift
//  StackAndScrollCode
//
//  Created by Kay on 2022/08/04.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
   
    let horizontalStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    let verticalStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        //stackView.backgroundColor = .orange
        stackView.spacing = 30
        return stackView
    }()
    
    let addButton: UIButton = {
        var button = UIButton()
        button.setTitle("ADD", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(addBlackView), for: .touchUpInside)
        return button
    }()
    
    let removeButton: UIButton = {
        var button = UIButton()
        button.setTitle("REMOVE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    func scrollViewAutoLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor)
        ])
        
    }
    
    func horizontalStackViewAutoLayout() {
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
        
    func verticalStackViewAutoLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
    }
    
    @objc func addBlackView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.isHidden = true
        
        view.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        verticalStackView.addArrangedSubview(view)
        UIView.animate(withDuration: 0.3) {
            view.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: View에 스크롤뷰와 버튼스택뷰 추가
        view.addSubview(scrollView)
        view.addSubview(horizontalStackView)
        
        // MARK: 스크롤뷰에 verticalStackView 추가 및 오토레이아웃
        scrollView.addSubview(verticalStackView)
        verticalStackViewAutoLayout()
        
        // MARK: ScrollView AutoLayout 설정
        scrollViewAutoLayout()
        
        
        // MARK: Horizontal StavkView Add Arranged Subview
        horizontalStackView.addArrangedSubview(addButton)
        horizontalStackView.addArrangedSubview(removeButton)
        
        // MARK: Horizontal StackView AutoLayout 설정
        horizontalStackViewAutoLayout()
        
        
        
    }
    

}

