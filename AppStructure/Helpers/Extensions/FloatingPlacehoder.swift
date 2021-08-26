//
//  FloatingPlacehoder.swift
//  AppStructure
//
//  Created by Admin on 25/08/21.
//

import Foundation
import UIKit

class FloatingPlaceholder: UITextField {
    var floatingLabel: UILabel = UILabel(frame: CGRect.zero)
    var floatingErrorLabel: UILabel = UILabel(frame: CGRect.zero)
    var _placeholder: String?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder
        placeholder = self._placeholder
        self.floatingLabel = UILabel(frame: CGRect.zero)
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    }
    
    @objc func addFloatingLabel() {
        if self.text == "" {
            self.floatingLabel.textColor = .systemGray4
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.floatingLabel)
            self.floatingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
            self.placeholder = ""
        }
        self.setNeedsDisplay()
    }
    
    @objc func removeFloatingLabel() {
        if self.text == "" {
            UIView.animate(withDuration: 0.13) {
               self.subviews.forEach{ $0.removeFromSuperview() }
               self.setNeedsDisplay()
            }
            self.placeholder = self._placeholder
        }
    }
    
    func setLeftPadding(_ amount : CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setPlacehoder(_ placeholderText: String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2,
             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
    }
    
    func addErrorLabel(_ message: String) {
        self.floatingErrorLabel.textColor = .systemGray4
        self.floatingErrorLabel.text = message
        self.floatingErrorLabel.font = UIFont.systemFont(ofSize: 10)
        self.floatingErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.floatingErrorLabel)
        self.floatingErrorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        self.floatingErrorLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
        self.setNeedsDisplay()
    }
    
    func validationFail() {
        let iconImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 20, height: 20))
        let rightView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: 36, height: 20))
        rightView.addSubview(iconImageView)
        iconImageView.image = UIImage(systemName: "multiply.circle")!
        iconImageView.tintColor = .systemRed
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
    func validationSuccess() {
        let iconImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 20, height: 20))
        let rightView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: 36, height: 20))
        iconImageView.image = UIImage(systemName: "checkmark.circle")!
        iconImageView.tintColor = .green
        rightView.addSubview(iconImageView)
        self.rightView = rightView
        self.rightViewMode = .always
    }
}
