//
//  EmailModelController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/24/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class EmailModelController: ModelController {

    var model:EmailModel? {
        return _model as? EmailModel
    }
    
    var type:String {
        return model?.type ?? ""
    }
    
    var fullEmail:String {
        let emailAddress = model?.emailAddress ?? ""
        
        return "\(emailAddress)"
    }
}

extension EmailModelController:ModelCellDelegate {
    
    func rendering(cell: UITableViewCell) {
        if let thisCell = cell as? SimpleInformationCell {
            thisCell.typeLabel.text = type
            thisCell.infoLabel.text = fullEmail
            thisCell.infoLabel.textColor = UIColor(R: 21, G: 126, B: 251)
            thisCell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        }
        else if let thisCell = cell as? SimpleInformationEditCell {
            thisCell.typeBtn.setTitle(type, for: .normal)
            
            thisCell.infoTextField.keyboardType = .emailAddress
            thisCell.infoTextField.placeholder = "EMAIL".localized
            thisCell.infoTextField.text = fullEmail
        }
    }
}
