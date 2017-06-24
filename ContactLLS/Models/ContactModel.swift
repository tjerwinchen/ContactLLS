//
//  Contact.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/20/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit
import EVReflection

class ContactModel: EVObject {
    
    var avatar = ""
    var name = NameModel()
    var emailList:[EmailModel]? = nil
    var phoneList:[PhoneModel]? = nil
    var birthday = ""
}
