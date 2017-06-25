//
//  UIImage+Extension.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/23/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(withColor color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func scale(toSize:CGSize) -> UIImage {
        // Create a bitmap graphics context
        // This will also set it as the current context
        UIGraphicsBeginImageContext(size)
        
        // Draw the scaled image in the current context
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // Create a new image from current context
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Pop the current context from the stack
        UIGraphicsEndImageContext()
        
        // Return our new scaled image
        return scaledImage!
    }
}
