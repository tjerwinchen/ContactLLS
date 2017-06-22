//
//  UIColor+Extension.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(R: Int, G: Int, B: Int, A:CGFloat = 1.0) {
        assert(R >= 0 && R <= 255, "Invalid red component")
        assert(G >= 0 && G <= 255, "Invalid green component")
        assert(B >= 0 && B <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(R) / 255.0, green: CGFloat(G) / 255.0, blue: CGFloat(B) / 255.0, alpha: A)
    }
    
    convenience init(netHex:Int, alpha:CGFloat = 1.0) {
        self.init(R: (netHex >> 16) & 0xff, G: (netHex >> 8) & 0xff, B: netHex & 0xff, A: alpha)
    }
}
