//
//  UILabelExtension.swift
//  AppStructure
//
//  Created by Admin on 30/08/21.
//

import Foundation
import UIKit

extension UIView{
    
    func addGradient() {
        
        let view = UIView(frame: self.frame)
        self.addSubview(view)
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint =  CGPoint(x: 1.0, y: 0.5)
        self.layer.addSublayer(gradient)
        
        let animationGroup = addAnimation()
        animationGroup.beginTime = 0.0
        gradient.add(animationGroup, forKey: "backgroundColor")
        gradient.frame = self.bounds
  }
    
    func addAnimation()-> CAAnimationGroup {
        
        let animationDuration: CFTimeInterval = 1
        let anim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim.fromValue = UIColor.systemGray6.cgColor
        anim.toValue = UIColor.systemGray3.cgColor
        anim.duration = animationDuration
        anim.beginTime = 0.0
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animation.fromValue = UIColor.systemGray3.cgColor
        animation.toValue = UIColor.systemGray6.cgColor
        animation.duration = animationDuration
        animation.beginTime = anim.beginTime + anim.duration

        let group = CAAnimationGroup()
        group.animations = [anim,animation]
        group.duration = anim.duration + animation.duration
        
        return group
    }
}
