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
    
    func toDate(dateFormat:String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
}
