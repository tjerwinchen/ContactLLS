//
//  SimpleInformationEditCell.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/25/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class SimpleInformationEditCell: UITableViewCell, CellInterface {

    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var infoTextField: UITextField!
    
    var modelDelegate:ModelCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func rendering() {
        modelDelegate?.rendering?(cell: self)
    }
}
