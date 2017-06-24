//
//  ModelCellDelegate.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

protocol ModelCellDelegate:NSObjectProtocol {
    
    func rendering(cell:UITableViewCell)
    func rendering(view:UIView)

}
