//
//  ContactDetailViewController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit
import SnapKit

class ContactDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var headerView = ContactDetailHeaderView()
    
    var contactModelCtrl: ContactModelController! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bNeedTransparentNavigationBar = true
        
        let headerView = ContactDetailHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        headerView.awakeFromNib()
        headerView.modelDelegate = contactModelCtrl
        headerView.rendering()
        
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = UIColor(R: 250, G: 250, B: 255)
        tableView.register(SimpleInformationCell.cellNib, forCellReuseIdentifier: SimpleInformationCell.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ContactDetailViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleInformationCell.id) as! SimpleInformationCell
        
        cell.modelDelegate = contactModelCtrl.phoneList[indexPath.row]
        cell.rendering()
        
        // 最后一行
        if indexPath.row == contactModelCtrl.phoneList.count - 1 {
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactModelCtrl.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactModelCtrl.phoneList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    var headerOffset:CGFloat {
        return 100.0 - statusBarHeight - navigationBarHeight
    }
    
    var barOffset:CGFloat {
        return statusBarHeight+navigationBarHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentContentOffset = scrollView.contentOffset
        
        
        //print(currentContentOffset.y)

//        if currentContentOffset.y > headerOffset {
//            scrollView.contentOffset.y = headerOffset
//            
//            headerView.awakeFromNib()
//        }
        
        if currentContentOffset.y < -barOffset*2 {
            scrollView.contentOffset.y = -barOffset*2
        }
        
        else {
            if let headerView = self.tableView.tableHeaderView as? ContactDetailHeaderView {
                
                headerView.updateLayout(offsetY:currentContentOffset.y)
            }
        }
    }
}
