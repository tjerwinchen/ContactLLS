//
//  ModelController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/24/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit
import EVReflection

class ModelController: NSObject {
    var _model:Model? = nil
    
    convenience init(model:Model) {
        self.init()
        self._model = model
    }
}
