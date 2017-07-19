//
//  ManageUser.swift
//  Gedeti
//
//  Created by Christophe Fauchère on 10.02.16.
//  Copyright © 2016 Gedeti Entreprise. All rights reserved.
//

class ManageUser: UIViewController {
    var items: NSMutableArray = []
    var idUser = ""
    @IBOutlet weak var detailMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailMessage.text = idUser
    }
}