//
//  Menu.swift
//  Gedeti
//
//  Created by christophe fauchere on 16.12.15.
//  Copyright © 2015 Gedeti Entreprise. All rights reserved.
//

class Menu: UIViewController {
    @IBOutlet weak var displayType: UILabel!
    @IBOutlet weak var displayNom: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var manageUser: UIButton!
    @IBOutlet weak var ticketsWaiting: UIButton!
    @IBOutlet weak var ticketsSolved: UIButton!
    
    //Ma variable qui enregistre en local les info de l'user (login)
    let loginVar:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Wallpaper.png")!)
        //(red: 25/255.0, green: 177/255.0, blue: 254/255.0, alpha: 1.0)
        let statut = loginVar.valueForKey("statut") as? String
        displayType.text = statut
        displayNom.text = loginVar.valueForKey("pseudo") as? String
        
        //Teste le statut de l'utilsateur pour afficher l'image correspondante
        if(statut == "Utilisateur"){
            ticketsWaiting.hidden = true
            manageUser.hidden = true
            ticketsSolved.hidden = true
            imgUser.image = UIImage(named: "user")!
        }else if(statut == "Technicien"){
            manageUser.hidden = true
            imgUser.image = UIImage(named: "tech")!
        }else{
            imgUser.image = UIImage(named: "admin")!
        }
    }
    
    @IBAction func SignOut(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults()
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        loginVar.setInteger(0, forKey: "isLog")
        self.performSegueWithIdentifier("r2", sender: self)
    }
}
