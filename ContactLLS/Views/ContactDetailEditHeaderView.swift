//
//  ContactDetailEditHeaderView.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/25/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

enum ContactEditStatus:String {
    case add = "ADD"
    case edit = "EDIT"
}

protocol ContactDetailEditHeaderViewDelegate:NSObjectProtocol {
    
    func addPhoto(headerView: ContactDetailEditHeaderView)
}

class ContactDetailEditHeaderView: UIView {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet var nameTextFieldList: [UITextField]!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    var delegate:ContactDetailEditHeaderViewDelegate? = nil
    
    var status:ContactEditStatus = .add {
        didSet {
            switch(status) {
            case .add:
                editBtn.isHidden = true
                imgView.image = UIImage(named: "default_contact")?.withRenderingMode(.alwaysTemplate)
                imgView.tintColor = UIColor(R: 228, G: 228, B: 228)
            case .edit:
                editBtn.isHidden = false
            }
            
            addBtn.isHidden = !editBtn.isHidden
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        imgView.layer.cornerRadius = 24
        imgView.layer.masksToBounds = true
        
        for tf in nameTextFieldList {
            tf.delegate = self
        }
        
        addBtn.titleLabel?.lineBreakMode = .byWordWrapping
        addBtn.titleLabel?.textAlignment = .center
        addBtn.setTitle("ADD_PHOTO".localized, for: .normal)
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        
        addBtn.whenTouchUpInside { [unowned self] in
            self.delegate?.addPhoto(headerView: self)
        }
    }
}

extension ContactDetailEditHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let index = nameTextFieldList.index { (thisTextField) -> Bool in
            return thisTextField == textField
        }
        
        let nextIndex = (index!+1) % nameTextFieldList.count
        
        nameTextFieldList[nextIndex].becomeFirstResponder()
        
        return true
    }
}
