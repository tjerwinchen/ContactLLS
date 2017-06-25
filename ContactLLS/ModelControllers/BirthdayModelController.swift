//
//  BirthdayModelController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/24/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class BirthdayModelController: ModelController {
    
    var model:BirthdayModel? {
        return _model as? BirthdayModel
    }
    
    var type:String {
        return model?.type ?? ""
    }
    
    var birthday:String {
        return model?.birthday ?? ""
    }
    
    var birthdayDate:Date? {
        return birthday.toDate()
    }
    
    var birthdayReadable:String {
        return birthdayDate?.toString(dateFormat: "MMMM d, YYYY") ?? ""
    }
}

extension BirthdayModelController:ModelCellDelegate {
    
    func rendering(cell: UITableViewCell) {
        if let thisCell = cell as? SimpleInformationCell {
            thisCell.typeLabel.text = type
            thisCell.infoLabel.text = birthdayReadable
            thisCell.infoLabel.textColor = UIColor(R: 21, G: 126, B: 251)
            thisCell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        }
    }
}
