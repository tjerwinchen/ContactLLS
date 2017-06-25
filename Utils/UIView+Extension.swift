//
//  UIView+Extension.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

private var kWhenTappedBlockKey: String = "kWhenTappedBlockKey"

typealias ActionClosure = @convention(block) () -> ()

extension UIView: UIGestureRecognizerDelegate {
    
    // 增加Gradients Color
    func addGradient(fromColor: UIColor, toColor:UIColor, inFrame frame:CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [toColor.cgColor, fromColor.cgColor]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addTapGestureRecognizerWithTaps(taps:Int, touches:Int, action: Selector?) -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = taps
        tapGesture.numberOfTouchesRequired = touches
        addGestureRecognizer(tapGesture)
        
        return tapGesture
    }
    
    func viewWasTapped() {
        runClosure(forKey: &kWhenTappedBlockKey)
    }
    
    func runClosure(forKey key:UnsafeRawPointer!) {
        let closureObject = objc_getAssociatedObject(self, key) as AnyObject
        let closure = unsafeBitCast(closureObject, to: ActionClosure.self)
        closure()
    }
    
    // 增加Tap
    func whenTapped(viewWasTapped:ActionClosure) {
        let gesture = addTapGestureRecognizerWithTaps(taps: 1, touches: 1, action:#selector(UIView.viewWasTapped))
        
        addRequiredToDoubleTapsRecognizer(recognizer: gesture)
        
        isUserInteractionEnabled = true
        
        let closureObject: AnyObject = unsafeBitCast(viewWasTapped, to: AnyObject.self)
        objc_setAssociatedObject(self, &kWhenTappedBlockKey, closureObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func addRequiredToDoubleTapsRecognizer(recognizer:UIGestureRecognizer) {
        for gesture in self.gestureRecognizers! {
            if gesture.isKind(of: UITapGestureRecognizer.self) {
                if let tapGesture = gesture as? UITapGestureRecognizer {
                    if tapGesture.numberOfTouchesRequired == 2 && tapGesture.numberOfTapsRequired == 1 {
                        recognizer.require(toFail: tapGesture)
                    }
                }
            }
        }
    }
}

