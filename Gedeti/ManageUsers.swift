//
//  ManageUsers.swift
//  Gedeti
//
//  Created by christophe fauchere on 16.12.15.
//  Copyright © 2015 Gedeti Entreprise. All rights reserved.
//

class ManageUsers: UITableViewController {
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    var items: NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        let url = "show_users"
        let data = ""
        getData2(url, info: data , completionHandler: {data, error -> Void in
            if (data != nil) {
                self.items = NSMutableArray(array: data)
            } else {
                print("api.getData failed")
                print(error)
            }
            self.tableView.reloadData()
        })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let dict = items[indexPath.row]
        
        cell.textLabel!.text = dict["Username"] as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.tableView!.indexPathForSelectedRow
        let manageUser: ManageUser = segue.destinationViewController as! ManageUser
        manageUser.idUser = items[indexPath!.row]["Prenom"] as! String
    
    }
    
}