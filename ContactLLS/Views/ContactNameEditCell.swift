//
//  ContactNameEditCell.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/25/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class BottomLineView:UIView {
    
    override func draw(_ rect: CGRect) {
        
        let bottomBorderlayer = CALayer()
        bottomBorderlayer.frame = CGRect(x: 0, y: self.bounds.height-1.0, width: self.bounds.width, height: 1.0)
        bottomBorderlayer.backgroundColor = UIColor.lightGray.cgColor
        
        layer.addSublayer(bottomBorderlayer)
    }
    
}

class ContactNameEditCell: UITableViewCell, CellInterface {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
