//
//  ViewController.swift
//  Gedeti
//
//  Created by christophe fauchere on 16.12.15.
//  Copyright © 2015 Gedeti Entreprise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //TextFileds
    @IBOutlet weak var pseudoChamp: UITextField!
    @IBOutlet weak var mdpChamp: UITextField!
    //Ma variable qui enregistre en local les info de l'user (login)
    let loginVar:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var testKeyboard:Bool = false // variable pour tester si le clavier est ouvert
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Changer background page de login
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Wallpaper.png")!)
    }
    
    //code à charger après le chargement de la vue
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //test si l'user est deja loguer pour passer a la page d'accueil
        let estLoguer:Int = loginVar.integerForKey("isLog") as Int
        if(estLoguer == 1){
            self.performSegueWithIdentifier("r", sender: self)
        }
        //Déplace le claiver si une textfield est selectionnée
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    //clavier est présent
    func keyboardWillShow(sender: NSNotification) {
        if(testKeyboard == false){
            self.view.frame.origin.y -= 150
            testKeyboard = true
        }
    }
    
    //clavier ce ferme
    func keyboardWillHide(sender: NSNotification) {
        if(testKeyboard == true){
            self.view.frame.origin.y += 150
            testKeyboard = false
        }
    }
    
    //Fonction sur le bouton connecter
    @IBAction func seConnecter(sender: AnyObject) {
        let username:NSString = pseudoChamp.text!
        let password:NSString = mdpChamp.text!
        
        //si les champs sont vides
        if( username.isEqualToString("") || password.isEqualToString("") ){
            PopUp("Entrez vos identifiants")
        }else{ //si les champs ne sont pas vide
            let strPseudo = "\"pseudo\":\"\(username)\""
            let strMDP = "\"mdp\":\"\(password)\""
            let data = "[{"+strPseudo+","+strMDP+"}]"
            let url = "login"
            Connexion(data, url: url)
            let estLoguer:Int = loginVar.integerForKey("isLog") as Int
            if(estLoguer == 1){
                self.performSegueWithIdentifier("r", sender: self)
            }
        }
    }
}

