//
//  ContactDetailHeaderView.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit
import SnapKit

class ContactDetailHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var modelDelegate:ModelCellDelegate? = nil
    
    let kImageWidth:CGFloat = 84.0
    let kCenterYOffset:CGFloat = -70.0
    
    let actionView:ContactDetailHeaderActionView = Bundle.main.loadNibNamed("ContactDetailHeaderActionView", owner: self, options: nil)![0] as! ContactDetailHeaderActionView
    let imgView = UIImageView(image: UIImage.image(withColor: UIColor.gray, size: CGSize(width: 100, height: 100)))
    let nameLabel = UILabel()
    
    override func awakeFromNib() {
        backgroundColor = UIColor(R: 250, G: 250, B: 255)
        actionViewDidLoad()
        imgViewDidLoad()
        nameLabelDidLoad()
    }
    
    func actionViewDidLoad() {
        addSubview(actionView)
    }
    
    func imgViewDidLoad() {
        addSubview(imgView)
        imgView.layer.masksToBounds = true
    }
    
    func nameLabelDidLoad() {
        addSubview(nameLabel)
        nameLabel.text = "Hello World"
    }
    
    // 跟随滚动进行变形
    func updateLayout(offsetY:CGFloat) {
        
        let adjustedOffsetY = 64+offsetY
        
        print("\(offsetY)")
        print("\(adjustedOffsetY)")

        let imgWidth = max(kImageWidth - adjustedOffsetY*0.8, 48)
        imgView.layer.cornerRadius = imgWidth/2.0
        
        print(imgWidth)
        var centerYOffset = kCenterYOffset
        if adjustedOffsetY >= 50 {
            centerYOffset = kCenterYOffset - (50-adjustedOffsetY)
        }
        
        print("centerYOffset:\(centerYOffset)")
        
        print("imgWidth:\(imgWidth)")
        
        imgView.snp.remakeConstraints { [unowned self] (imgViewMake) in
            imgViewMake.centerX.equalTo(self.snp.centerX)
            imgViewMake.centerY.equalTo(self.snp.centerY).offset(centerYOffset)
            imgViewMake.height.equalTo(imgWidth)
            imgViewMake.width.equalTo(imgWidth)
        }
        
        let fontSize = max(20.0 - adjustedOffsetY/10.0, 12.0)
        
        nameLabel.font = UIFont.systemFont(ofSize: fontSize)
        nameLabel.snp.remakeConstraints { [unowned self] (nameLabelMake) in
            nameLabelMake.centerX.equalTo(self.snp.centerX)
            nameLabelMake.top.equalTo(self.imgView.snp.bottom).offset(8.0)
        }
        
        actionView.snp.remakeConstraints { [unowned self] (backgroundViewMake) in
            backgroundViewMake.centerX.equalTo(self.snp.centerX)
            backgroundViewMake.centerY.equalTo(self.snp.centerY).offset(centerYOffset-10)
            backgroundViewMake.bottom.equalTo(self.nameLabel.snp.bottom).offset(100)
            backgroundViewMake.width.equalTo(self.snp.width)
        }
    }
    
    func rendering() {
        modelDelegate?.rendering?(view: self)
    }
}
