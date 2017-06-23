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
    
    func moveVertically(_ dltY:CGFloat, minY:CGFloat, maxY:CGFloat) {
        var newFrame = self.frame
        newFrame.origin.y += dltY
        newFrame.origin.y = min(newFrame.origin.y, maxY)
        newFrame.origin.y = max(newFrame.origin.y, minY)
        
        print(newFrame.origin.y)
        self.frame = newFrame
    }
    
    func stratchVertically(_ dltY:CGFloat) {
        var newFrame = self.frame
        newFrame.origin.y += dltY
        newFrame.size.height -= dltY
        self.frame = newFrame
    }
}
