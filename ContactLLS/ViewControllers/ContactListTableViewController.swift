//
//  ContactListTableViewController.swift
//  ContactLLS
//
//  Created by Theo Chen on 6/20/17.
//  Copyright © 2017 Theo Chen. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    var _searchController: UISearchController! = nil
    var _resultCtrl:ContactListSearchResultTableViewController! = nil
    
    var contactDict:[String:[ContactModel]] = [:]
    
    var resultCtrl:ContactListSearchResultTableViewController {
        if _resultCtrl == nil {
            _resultCtrl = self.storyboard!.instantiateViewController(withIdentifier: "ContactListSearchResultTableViewController") as! ContactListSearchResultTableViewController
        }
        
        return _resultCtrl
    }
    
    var searchController: UISearchController {
        if _searchController == nil {
            _searchController = UISearchController(searchResultsController: self.resultCtrl)
        }
        
        return _searchController
    }
    
    var sortedKeys:[String] {
        var keys = contactDict.keys.sorted()
        keys.remove(at: 0)
        keys.append("#")
        
        return keys
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.showsVerticalScrollIndicator = true
        
        tableView.register(ContactListTableViewCell.cellNib, forCellReuseIdentifier: ContactListTableViewCell.id)
        
        searchControllerDidLoad()
        
        let contactList = ContactModelController.loadMockContact()
        contactDict = ContactModelController.transformContactList2Dict(contactList: contactList)
    }
    
    func searchControllerDidLoad() {
        searchController.searchResultsUpdater = resultCtrl
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return contactDict.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let key = sortedKeys[section]
        let contactList = contactDict[key] ?? []
        return contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.id, for: indexPath) as! ContactListTableViewCell
        
        let key = sortedKeys[indexPath.section]
        let contactList = contactDict[key] ?? []
        
        cell.modelDelegate = ContactModelController(model: contactList[indexPath.row])
        cell.rendering()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedKeys[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let key = sortedKeys[indexPath.section]
        let contactList = contactDict[key] ?? []
        
        let contactModelCtrl = ContactModelController(model: contactList[indexPath.row])
        performSegue(withIdentifier: "showContactDetail", sender: contactModelCtrl)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? ContactDetailViewController,
            let contactModelCtrl = sender as? ContactModelController? {
            vc.contactModelCtrl = contactModelCtrl
        }
    }
}

extension ContactListTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension ContactListTableViewController: UISearchControllerDelegate {
    
    func willDismissSearchController(_ searchController: UISearchController) {
        
    }
}

