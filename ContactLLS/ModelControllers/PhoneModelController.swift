//
//  PhoneModelController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/24/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class PhoneModelController:NSObject {
    var model:PhoneModel? = nil
    
    convenience init(model:PhoneModel) {
        self.init()
        self.model = model
    }
    
    var type:String {
        return model?.type ?? ""
    }
    
    var fullNumber:String {
        let phoneNumber = model?.phoneNumber ?? ""
        let countryCode = model?.countryCode ?? ""
        
        return "\(countryCode) \(phoneNumber)"
    }
}

extension PhoneModelController:ModelCellDelegate {

    func rendering(cell: UITableViewCell) {
        if let thisCell = cell as? SimpleInformationCell {
            thisCell.typeLabel.text = type
            thisCell.infoLabel.text = fullNumber
            thisCell.infoLabel.textColor = UIColor(R: 21, G: 126, B: 251)
            thisCell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
            
            
        }
    }
}
