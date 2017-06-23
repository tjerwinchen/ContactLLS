//
//  ContactDetailViewController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit
import SnapKit

class ContactDetailTableView: UITableView {
//    var touchesIsBegin = false
//    var lastLocation = CGPoint(x: -999, y: -999)
//    
//    var controller:ContactDetailViewController? {
//        return delegate as? ContactDetailViewController
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        
//        touchesIsBegin = true
//        
//        if let touch = touches.first {
//            lastLocation = touch.location(in: controller?.view)
//        }
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesMoved(touches, with: event)
//        
//        if touchesIsBegin, let currentTouch = touches.first {
//            
//            //print("last:", self.lastLocation)
//            //print("current:", currentTouch.location(in: view))
//            
//            let currenLocation = currentTouch.location(in: controller?.view)
//            
//            let stepY = (currenLocation.y - lastLocation.y) / 1.5
//            
//            controller?.scrollHeaderViewUpward(yStep: stepY)
//            controller?.view.layoutIfNeeded()
//            
//            self.lastLocation = currenLocation
//        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        
//        touchesIsBegin = false
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesCancelled(touches, with: event)
//        
//        touchesIsBegin = false
//    }
//    
//    var lastContentOffset = CGPoint(x: 999, y: 999)
}

class ContactDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: ContactDetailTableView!
    @IBOutlet weak var headerView: ContactDetailHeaderView!
    
    override var entitlementBackgroundColor:UIColor {
        get {
            return UIColor.red
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bNeedTransparentNavigationBar = true
        
        //tableView.isScrollEnabled = false
        
        placeHeaderView(yPosition: 0.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollHeaderViewUpward(yStep:CGFloat) {
        var yPosition = headerView.frame.origin.y + yStep
        
        if yPosition > 0 {
            yPosition = 0
        }
        else if yPosition < -100 {
            yPosition = -100
        }
        
        placeHeaderView(yPosition: yPosition)
        
        print(yPosition)
        
//        if yPosition == -100 { // 到底段了
//            tableView.isScrollEnabled = true
//        }
//        else {
//            tableView.isScrollEnabled = false
//        }
    }
    
    func placeHeaderView(yPosition:CGFloat) {
        headerView.snp.remakeConstraints { [unowned self] (headerViewMake) in
            headerViewMake.top.equalTo(self.view.snp.top).offset(yPosition)
            headerViewMake.left.equalTo(self.view.snp.left)
            headerViewMake.right.equalTo(self.view.snp.right)
            headerViewMake.height.equalTo(300)
        }
        
        let offsetHeight = self.navigationBarHeight + self.statusBarHeight
        
        tableView.snp.remakeConstraints { [unowned self, offsetHeight] (tableViewMake) in
            tableViewMake.top.equalTo(self.headerView.snp.bottom).offset(-offsetHeight)
            tableViewMake.left.equalTo(self.view.snp.left)
            tableViewMake.right.equalTo(self.view.snp.right)
            tableViewMake.bottom.equalTo(self.view.snp.bottom)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var touchesIsBegin = false
    var lastLocation = CGPoint(x: -999, y: -999)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        touchesIsBegin = true
        
        if let touch = touches.first {
            lastLocation = touch.location(in: self.view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        if touchesIsBegin, let currentTouch = touches.first {
            
            //print("last:", self.lastLocation)
            //print("current:", currentTouch.location(in: view))

            let currenLocation = currentTouch.location(in: view)
            
            let stepY = (currenLocation.y - lastLocation.y) / 1.5
            
            scrollHeaderViewUpward(yStep: stepY)
            view.layoutIfNeeded()
        
            self.lastLocation = currenLocation
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        touchesIsBegin = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        touchesIsBegin = false
    }
    
    var lastContentOffset = CGPoint(x: 999, y: 999)

}

extension ContactDetailViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentContentOffset = scrollView.contentOffset
        
        let stepY = (currentContentOffset.y - lastContentOffset.y)
        
        scrollHeaderViewUpward(yStep: -stepY)
        view.layoutIfNeeded()
        
        lastContentOffset = currentContentOffset
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
