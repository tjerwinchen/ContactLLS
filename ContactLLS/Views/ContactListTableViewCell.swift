//
//  ContactListTableViewCell.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/20/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell, CellInterface {

    var modelDelegate:ModelCellDelegate? = nil
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func rendering() {
        modelDelegate?.rendering(cell: self)
    }
}
