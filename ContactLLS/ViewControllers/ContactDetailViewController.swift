//
//  ContactDetailViewController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/22/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit
import SnapKit
import MessageUI

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
        tableView.tableFooterView = UIView()
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
        
        let informationName = contactModelCtrl.informationNameList[indexPath.section]
        if let modelCtrlList = contactModelCtrl.value(forKey: informationName) as? [ModelController] {
            
            if let modelCtrl = modelCtrlList[indexPath.row] as? ModelCellDelegate {
                
                cell.modelDelegate = modelCtrl
            }
        }
        
        cell.rendering()
        
        // 最后一行
        if indexPath.row == contactModelCtrl.phoneList.count - 1 {
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactModelCtrl.informationNameList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let informationName = contactModelCtrl.informationNameList[section]
        if let list = contactModelCtrl.value(forKey: informationName) as? [ModelController] {
            return list.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let informationName = contactModelCtrl.informationNameList[indexPath.section]
        if let modelCtrlList = contactModelCtrl.value(forKey: informationName) as? [ModelController] {
            
            if let modelCtrl = modelCtrlList[indexPath.row] as? PhoneModelController {

                if let url = URL(string: "tel://\(modelCtrl.fullNumber.replacingOccurrences(of: " ", with: ""))"), UIApplication.shared.canOpenURL(url) {
                    
                    UIApplication.shared.open(url)
                }
            }
            else if let modelCtrl = modelCtrlList[indexPath.row] as? EmailModelController {
                
                sendMailInApp(emailAddress: modelCtrl.fullEmail)
            }
            else if let modelCtrl = modelCtrlList[indexPath.row] as? BirthdayModelController {
                
                if let url = URL(string: "calshow:\(modelCtrl.birthdayDate?.timeIntervalSinceReferenceDate ?? 0)"), UIApplication.shared.canOpenURL(url) {
                    
                    UIApplication.shared.open(url)
                }
            }
        }
        
    }
    
    func sendMailInApp(emailAddress:String) {
        
        let mailClass:AnyClass = NSClassFromString("MFMailComposeViewController")!
        
        guard mailClass.canSendMail() else {
            return
        }
        
        displayMailPicker(emailAddress: emailAddress)
    }
    
    func displayMailPicker(emailAddress:String) {
        // Email Subject
        let emailTitle = ""
        // Email Content
        let messageBody = ""
        // To address
        let toRecipents = [emailAddress]
        
        let mc = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        
        // Present mail view controller on screen
        self.present(mc, animated: true) {
            
        }
    }
    
    var barOffset:CGFloat {
        return statusBarHeight+navigationBarHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentContentOffset = scrollView.contentOffset
        
        //print(currentContentOffset.y)
        
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

extension ContactDetailViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        self.dismiss(animated: true) { () -> Void in
            
        }
        
        switch (result) {
        case MFMailComposeResult.cancelled:
            print("用户取消编辑邮件")
        case MFMailComposeResult.saved:
            print("用户成功保存邮件")
        case MFMailComposeResult.sent:
            print("用户点击发送，将邮件放到队列中，还没发送")
        case MFMailComposeResult.failed:
            print("用户试图保存或者发送邮件失败")
        }
    }
}
