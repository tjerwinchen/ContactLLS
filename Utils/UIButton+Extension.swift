//
//  UIButton+Extension.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/25/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import Foundation
import UIKit

private var kWhenTouchUpInsideKey: String = "kWhenTouchUpInsideKey"

extension UIButton {
    
    func touchUpInside() {
        runClosure(forKey: &kWhenTouchUpInsideKey)
    }
    
    // 增加Tap
    func whenTouchUpInside(buttonTouched:ActionClosure) {
        
        addTarget(self, action: #selector(UIButton.touchUpInside), for: .touchUpInside)
        let closureObject: AnyObject = unsafeBitCast(buttonTouched, to: AnyObject.self)
        
        objc_setAssociatedObject(self, &kWhenTouchUpInsideKey, closureObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
}
