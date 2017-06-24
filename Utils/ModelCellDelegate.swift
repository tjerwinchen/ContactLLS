//
//  ModelCellDelegate.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

@objc protocol ModelCellDelegate:NSObjectProtocol {
    
    @objc optional func rendering(cell:UITableViewCell)
    @objc optional func rendering(view:UIView)

}
