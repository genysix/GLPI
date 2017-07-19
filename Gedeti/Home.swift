//
//  Home.swift
//  Gedeti
//
//  Created by christophe fauchere on 16.12.15.
//  Copyright © 2015 Gedeti Entreprise. All rights reserved.
//

class Home: UIViewController {
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
