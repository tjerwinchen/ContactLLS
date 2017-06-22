//
//  Contact.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/20/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit
import EVReflection

class PhoneModel: EVObject {
    var countryCode = ""
    var phoneNumber = ""
}

class EmailModel: EVObject {
    var emailAddress = ""
}

class NameModel: EVObject {
    var firstName = ""
    var lastName = ""
}


class ContactModel: EVObject {
    
    var avatar = ""
    var name = NameModel()
    var emailList:[EmailModel]? = nil
    var phoneList:[PhoneModel]? = nil
    var birthday = ""
}
