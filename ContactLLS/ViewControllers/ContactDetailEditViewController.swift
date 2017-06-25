//
//  ContactDetailEditViewController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/25/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class BlankCell:UITableViewCell, CellInterface {
    
    override func draw(_ rect: CGRect) {
        contentView.backgroundColor = UIColor.white
        separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        selectionStyle = .none
    }
}

class ContactDetailEditViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contactModelCtrl = ContactModelController(model: ContactModel())
    
    var status:ContactEditStatus = .add
    let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "NEW_CONTACT".localized
        
        navigationBarDidLoad()
        tableViewDidLoad()
        
        imgPicker.delegate = self
    }
    
    func tableViewDidLoad() {
        let contactDetailEditHeaderView = Bundle.main.loadNibNamed("ContactDetailEditHeaderView", owner: self, options: nil)![0] as! ContactDetailEditHeaderView
        
        contactDetailEditHeaderView.delegate = self
        contactDetailEditHeaderView.status = .add
        tableView.tableHeaderView = contactDetailEditHeaderView
        tableView.setEditing(true, animated: true)
        tableView.allowsSelectionDuringEditing = true
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)) // delete later
        
        // register cell
        tableView.register(SimpleInformationAddCell.cellNib, forCellReuseIdentifier: SimpleInformationAddCell.id)
        tableView.register(BlankCell.self, forCellReuseIdentifier: BlankCell.id)
        tableView.register(SimpleInformationEditCell.cellNib, forCellReuseIdentifier: SimpleInformationEditCell.id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationBarDidLoad() {
        // Remove black bottom line in navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage.image(withColor: UIColor.white, size: CGSize(width: UIScreen.main.bounds.width, height: 66)), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func cancelBtnTouched(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
}

extension ContactDetailEditViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactModelCtrl.informationNameForEditList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let modelCtrlList = contactModelCtrl.value(forKey: contactModelCtrl.informationNameForEditList[section]) as? [ModelController] {
            
            return 2+modelCtrlList.count
        }
        
        return 2
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row == 0 {
            return false
        }
        else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BlankCell.id, for: indexPath)
            
            return cell
        }
        else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SimpleInformationAddCell.id, for: indexPath) as! SimpleInformationAddCell
            
            let key = contactModelCtrl.informationNameForEditList[indexPath.section]
            cell.titleLabel.text = ["phoneList": "ADD_PHONE",
                                    "emailList": "ADD_EMAIL",
                                    "birthdayList": "ADD_BIRTHDAY",
                                    ][key]?.localized
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SimpleInformationEditCell.id, for: indexPath) as! SimpleInformationEditCell
            
            let key = contactModelCtrl.informationNameForEditList[indexPath.section]
            
            if let modelCtrlList = contactModelCtrl.value(forKey: key) as? [ModelController] {
                
                if let modelCtrl = modelCtrlList[indexPath.row-1] as? ModelCellDelegate {
                    
                    cell.modelDelegate = modelCtrl
                }
            }
            
            cell.rendering()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 点击的是最后一行cell,即增加一条信息
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            
            let key = contactModelCtrl.informationNameForEditList[indexPath.section]
            
            switch(key) {
            case "phoneList":
                let phoneModel = PhoneModel()
                phoneModel.type = "Home"
                contactModelCtrl.appendPhone(phoneModel:phoneModel)
            case "emailList":
                let emailModel = EmailModel()
                emailModel.type = "Home"
                contactModelCtrl.appendEmail(emailModel:emailModel)
            case "birthdayList":
                let birthdayModel = BirthdayModel()
                birthdayModel.type = "birthday"
                contactModelCtrl.appendBirthday(birthdayModel:birthdayModel)
            default:
                break
            }
            tableView.reloadSections([indexPath.section], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension ContactDetailEditViewController:
    ContactDetailEditHeaderViewDelegate,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    func addPhoto(headerView: ContactDetailEditHeaderView) {
        
        // 1
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 2
        let cameraAction = UIAlertAction(title: "Take a photo", style: .default) { (alert) in
            
            self.imgPicker.allowsEditing = false
            self.imgPicker.sourceType = UIImagePickerControllerSourceType.camera
            self.imgPicker.cameraCaptureMode = .photo
            
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
        let photoLibraryAction = UIAlertAction(title: "CHOOSE_PHOTO".localized, style: .default) { (alert) -> Void in
            
            self.imgPicker.allowsEditing = false //2
            self.imgPicker.sourceType = .photoLibrary //3
            self.imgPicker.modalPresentationStyle = .popover
            
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
        }
        
        // 4
        if UIImagePickerController.isCameraDeviceAvailable(.rear) || UIImagePickerController.isCameraDeviceAvailable(.front) {
            optionMenu.addAction(cameraAction)
        }
        optionMenu.addAction(photoLibraryAction)
        optionMenu.addAction(cancelAction)
        
        present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 开始弹出image cropper view controller
        picker.dismiss(animated: true) { [unowned self] in
            // present the cropper view controller
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            let imgCropperVC = VPImageCropperViewController(image: image, cropFrame: CGRect(x: 0, y: 100.0, width: self.view.frame.size.width, height: self.view.frame.size.width), limitScaleRatio: 3)
            imgCropperVC?.delegate = self
            self.present(imgCropperVC!, animated: true) { (complete) in
                
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ContactDetailEditViewController: VPImageCropperDelegate {
    
    func imageCropper(_ cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        
        if let headerView = tableView.tableHeaderView as? ContactDetailEditHeaderView {
            
            let avatar = editedImage.scale(toSize: CGSize(width: 256, height: 256))
            headerView.imgView.image = avatar.withRenderingMode(.alwaysOriginal)
            
            status = .edit
            headerView.status = status
        }
    }
    
    func imageCropperDidCancel(_ cropperViewController: VPImageCropperViewController!) {
    }
}

