//
//  String+Extension.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/20/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

extension String {
    
    var localized:String! {
        return NSLocalizedString(self, comment: "")
    }
}
