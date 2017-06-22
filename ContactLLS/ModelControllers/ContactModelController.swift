//
//  ContactModelController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class ContactModelController: NSObject {
    
    var model:ContactModel? = nil
    
    static func loadMockContact() -> [ContactModel] {
        
        var contactModelList:[ContactModel] = []
        
        if let path = Bundle.main.path(forResource: "mock_contacts", ofType: "json") {
            let contactJSONString = try! String(contentsOf: URL(fileURLWithPath: path))
            contactModelList = [ContactModel](json:contactJSONString)
            print(contactModelList)

        }
        
        return contactModelList
    }
}
