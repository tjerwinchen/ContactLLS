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
        
        // register cell
        tableView.register(SimpleInformationAddCell.cellNib, forCellReuseIdentifier: SimpleInformationAddCell.id)
        tableView.register(BlankCell.self, forCellReuseIdentifier: BlankCell.id)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BlankCell.id, for: indexPath)
            
            return cell
        }
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SimpleInformationAddCell.id, for: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

