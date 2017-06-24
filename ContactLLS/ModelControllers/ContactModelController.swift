//
//  ContactModelController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class NameModelController:ModelController {
    var model:NameModel? {
        return _model as? NameModel
    }
    
    var fullName:String {
        let firstName = model?.firstName ?? ""
        let lastName = model?.lastName ?? ""
        
        return "\(firstName) \(lastName)"
    }
}

class ContactModelController: NSObject {
    
    var model:ContactModel? = nil
    
    var fullName:String {
        
        guard model?.name != nil else {
            return ""
        }
        
        return NameModelController(model: model!.name).fullName
    }
    
    var firstName:String {
        return model?.name.firstName.trimmingCharacters(in: [" "]) ?? ""
    }
    
    var lastName:String {
        return model?.name.lastName.trimmingCharacters(in: [" "]) ?? ""
    }
    
    var lastNameLabelFont:UIFont {
        return UIFont.boldSystemFont(ofSize: 17.0)
    }
    
    var firstNameLabelFont:UIFont {
        if lastName == "" {
            return UIFont.boldSystemFont(ofSize: 17.0)
        }
        return UIFont.systemFont(ofSize: 17.0)
    }
    
    var phoneList:[PhoneModelController] {
        var mc:[PhoneModelController] = []
        
        let phoneModelList = model?.phoneList ?? []
        
        for phoneModel in phoneModelList {
            let phoneModelCtrl = PhoneModelController(model: phoneModel)
            mc.append(phoneModelCtrl)
        }
        
        return mc
    }
    
    var emailList:[EmailModelController] {
        var mc:[EmailModelController] = []
        
        let emailModelList = model?.emailList ?? []
        
        for emailModel in emailModelList {
            let emailModelCrl = EmailModelController(model: emailModel)
            mc.append(emailModelCrl)
        }
        
        return mc
    }
    
    var birthdayList:[BirthdayModelController] {
        var mc:[BirthdayModelController] = []
        
        let birthdayModelList = model?.birthdayList ?? []
        
        for birthdayModel in birthdayModelList {
            let birthdayModelCrl = BirthdayModelController(model: birthdayModel)
            mc.append(birthdayModelCrl)
        }
        
        return mc
    }
    
    static func loadMockContact() -> [ContactModel] {
        
        var contactModelList:[ContactModel] = []
        
        if let path = Bundle.main.path(forResource: "mock_contacts", ofType: "json") {
            let contactJSONString = try! String(contentsOf: URL(fileURLWithPath: path))
            contactModelList = [ContactModel](json:contactJSONString)
            print(contactModelList)

        }
        
        return contactModelList
    }
    
    static func transformContactList2Dict(contactList:[ContactModel]) -> [String:[ContactModel]] {
        var contactDict:[String:[ContactModel]] = [:]
        
        for contact in contactList {
            var alphabetLetter = "#"
            
            let contactModelCtrl = ContactModelController(model: contact)
            if contactModelCtrl.lastName.lengthOfBytes(using: .utf8) > 0 {
                
                alphabetLetter = String(contactModelCtrl.lastName.characters.first!).uppercased()
            }
            else if contactModelCtrl.firstName.lengthOfBytes(using: .utf8) > 0 {
                
                alphabetLetter = String(contactModelCtrl.firstName.characters.first!).uppercased()
            }
            
            if "ABCDEFGHIJKLMNOPQRSTUVWXYZ".range(of: alphabetLetter) == nil {
                alphabetLetter = "#"
            }
            
            if contactDict[alphabetLetter] == nil {
                contactDict[alphabetLetter] = []
            }
            contactDict[alphabetLetter]?.append(contact)
        }
        
        return contactDict
    }
        
    convenience init(model:ContactModel) {
        self.init()
        self.model = model
    }
    
    var informationNameList:[String] {
        
        var _informationNameList:[String] = []
        
        if phoneList.count > 0 {
            _informationNameList.append("phoneList")
        }
        if emailList.count > 0 {
            _informationNameList.append("emailList")
        }
        if birthdayList.count > 0 {
            _informationNameList.append("birthdayList")
        }
        
        return _informationNameList
    }
}

extension ContactModelController:ModelCellDelegate {
    
    func rendering(cell: UITableViewCell) {
        if let thisCell = cell as? ContactListTableViewCell {
            thisCell.firstNameLabel.text = firstName
            thisCell.lastNameLabel.text = lastName
            
            thisCell.firstNameLabel.font = firstNameLabelFont
            thisCell.lastNameLabel.font = lastNameLabelFont
        }
    }
    
    func rendering(view: UIView) {
        if let thisView = view as? ContactDetailHeaderView {
            thisView.nameLabel.text = fullName
        }
    }
}
