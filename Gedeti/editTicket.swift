//
//  editTicket.swift
//  Gedeti
//
//  Created by Christophe Fauchère on 12.01.16.
//  Copyright © 2016 Gedeti Entreprise. All rights reserved.
//

import Foundation
import UIKit

class editTicket: UIViewController {
    var idTicket = ""
    var items: NSMutableArray = []
    var titreTicket = ""
    @IBOutlet weak var detailMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailMessage.text = titreTicket
        let url = "allTicketsActions"
        let data = "[{\"id\":\"3\"}]"
        getData2(url, info: data , completionHandler: {data, error -> Void in
            if (data != nil) {
                self.items = NSMutableArray(array: data)
            } else {
                print("api.getData failed")
                print(error)
            }
        })
    }
}