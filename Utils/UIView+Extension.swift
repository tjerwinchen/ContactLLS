//
//  UIView+Extension.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

extension UIView {
    func moveUpward(_ dltY:CGFloat) {
        self.moveVertically(-dltY)
    }
    
    func moveDownward(_ dltY:CGFloat) {
        self.moveVertically(dltY)
        
    }
    
    func moveLeft(_ dltX:CGFloat) {
        self.moveHorizentally(-dltX)
    }
    
    func moveRight(_ dltX:CGFloat) {
        self.moveHorizentally(dltX)
    }
    
    func moveHorizentally(_ dltX:CGFloat) {
        var newFrame = self.frame
        newFrame.origin.x += dltX
        self.frame = newFrame
    }
    
    func moveVertically(_ dltY:CGFloat) {
        var newFrame = self.frame
        newFrame.origin.y += dltY
        self.frame = newFrame
    }
}
