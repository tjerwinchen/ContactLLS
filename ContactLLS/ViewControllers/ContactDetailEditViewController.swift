//
//  ContactDetailEditViewController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/25/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class ContactDetailEditViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "NEW_CONTACT".localized
        
        navigationBarDidLoad()
        tableView.tableHeaderView = Bundle.main.loadNibNamed("ContactDetailEditHeaderView", owner: self, options: nil)![0] as! ContactDetailEditHeaderView
        
        tableView.register(ContactNameEditCell.cellNib, forCellReuseIdentifier: ContactNameEditCell.id)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactNameEditCell.id, for:indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}
