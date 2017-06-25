//
//  SimpleInformationAddCell.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/25/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class SimpleInformationAddCell: UITableViewCell, CellInterface {

    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.image = UIImage(named:"add")?.withRenderingMode(.alwaysTemplate)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
