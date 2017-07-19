//
//  MyTickets.swift
//  Gedeti
//
//  Created by christophe fauchere on 16.12.15.
//  Copyright © 2015 Gedeti Entreprise. All rights reserved.
//
import Foundation
import UIKit

class MyTickets: UITableViewController {
    var items: NSMutableArray = []
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        let url = "TicketsUserShow"
        let data = "[{\"id\":\"5\"}]"
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
        
        cell.textLabel!.text = dict["Titre"] as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.tableView!.indexPathForSelectedRow
        let detailTicket: editTicket = segue.destinationViewController as! editTicket
        detailTicket.idTicket = items[indexPath!.row]["ID"] as! String
        detailTicket.titreTicket = items[indexPath!.row]["Titre"] as! String
    }
    
}