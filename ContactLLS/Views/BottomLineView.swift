//
//  BottomLineView.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/25/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class BottomLineView:UIView {
    
    override func draw(_ rect: CGRect) {
        
        let bottomBorderlayer = CALayer()
        bottomBorderlayer.frame = CGRect(x: 0, y: self.bounds.height-1.0, width: self.bounds.width, height: 0.5)
        bottomBorderlayer.backgroundColor = UIColor.lightGray.cgColor
        
        layer.addSublayer(bottomBorderlayer)
    }
}
