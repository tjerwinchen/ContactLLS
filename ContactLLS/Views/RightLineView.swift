//
//  RightLineView.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/25/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class RightLineView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let bottomBorderlayer = CALayer()
        bottomBorderlayer.frame = CGRect(x: self.bounds.width-1.0, y: 0, width: 0.5, height: self.bounds.height)
        bottomBorderlayer.backgroundColor = UIColor.lightGray.cgColor
        
        layer.addSublayer(bottomBorderlayer)
    }

}
