//
//  CircularTransition.swift
//  AppStructure
//
//  Created by Admin on 23/08/21.
//
//
//import Foundation
import UIKit

class CircularTransition: NSObject {
    var circle = UIView()
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    var circleColor = UIColor.white
    var duration = 0.5
    
    enum circularTransitioningMode:Int{
        case present,dismiss,pop
    }
    var transitioningMode:circularTransitioningMode = .present
}
extension CircularTransition:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        TimeInterval(duration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if transitioningMode == .present{
            if let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to){
               
                let viewCenter = presentView.center
                let viewSize = presentView.frame.size
                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.height / 2
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                containerView.addSubview(circle)
                
                presentView.center = startingPoint
                presentView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                presentView.alpha = 0
                containerView.addSubview(presentView)
                
                UIView.animate(withDuration: TimeInterval(duration)) {
                    
                        self.circle.transform = CGAffineTransform.identity
                        presentView.transform = CGAffineTransform.identity
                        presentView.alpha = 1
                        presentView.center = viewCenter
                        
                    
                } completion: { (success) in
                    transitionContext.completeTransition(success)
                }
            }
        } else {
            let transitionModeKey = (transitioningMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey){
                let viewCenter = returningView.center
                let viewSixe = returningView.frame.size
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSixe, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: TimeInterval(duration)) {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    if self.transitioningMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                } completion: { success in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                }

            }
        }
    }

    func frameForCircle(withViewCenter viewCenter:CGPoint,size viewSize:CGSize,startPoint:CGPoint)-> CGRect{

        let xlength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let ylength = fmax(startPoint.y, viewSize.width - startPoint.y)
    
        let offsetVector = sqrt(xlength*xlength + ylength*ylength)*2
        let size = CGSize(width: offsetVector, height: offsetVector)
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
