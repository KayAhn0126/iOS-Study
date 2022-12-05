//
//  UILabel+Extension.swift
//  SettingAttributesOfLabelThroughExtensions
//
//  Created by Kay on 2022/12/05.
//

import Foundation
import UIKit

extension UILabel {
    /*
    func bold() {
        let fontSize = self.font.pointSize
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: fullText)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
    
    func bold(targetString: String) {
        let fontSize = self.font.pointSize
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
    */
    
    func bold(_ targetString: String? = nil) {
        let fontSize = self.font.pointSize
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let fullText = self.text ?? ""
        let retrievedTargetString = targetString ?? fullText
        let range: NSRange = (fullText as NSString).range(of: retrievedTargetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
}
