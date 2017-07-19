//
//  Function.swift
//  Gedeti
//
//  Created by christophe fauchere on 16.12.15.
//  Copyright © 2015 Gedeti Entreprise. All rights reserved.
//
import Foundation

//Ma variable qui enregistre en local les info de l'user (login)
let loginVar:NSUserDefaults = NSUserDefaults.standardUserDefaults()

//Function POPUP ou on passe le message par paramètre
func PopUp(Message: String){
    let alertView:UIAlertView = UIAlertView()
    alertView.title = "Erreur"
    alertView.message = Message
    alertView.addButtonWithTitle("OK")
    alertView.show()
}

func getData2(url: String, info: String, completionHandler: ((NSMutableArray!, NSError!) -> Void)!) -> Void {
    let request = NSMutableURLRequest(URL: NSURL(string: "http://genysix.alwaysdata.net/"+url+".php")!)
    request.HTTPMethod = "POST"
    let bodyData = info
    request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
        do {
            if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSMutableArray {
                print(json)
                return completionHandler(json, nil)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    task.resume()
}


//Fonction JSON
func Connexion(data: String, url: String){
    let session = NSURLSession.sharedSession()
    let request = NSMutableURLRequest(URL: NSURL(string: "http://genysix.alwaysdata.net/"+url+".php")!)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.HTTPMethod = "POST"
    request.HTTPBody = data.dataUsingEncoding(NSASCIIStringEncoding)
    let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
        if let _ = error {
            PopUp("Pas de connexion internet")
        }
        if let response = response {
            //Tester si la réponse est bonne par rapport au code d'erreur http
            let httpResponse = response as! NSHTTPURLResponse
            if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300){
                //Si la réponse est du JSON
                do{
                    let resultJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
                    if(resultJSON.valueForKey("id") as! NSString == ""){
                        if(url == "login.php"){
                            PopUp("Vos identifiants ne correspondent pas !")
                        }else{
                            PopUp("Il n'y a pas de donnée")
                        }
                    }else{
                        for(key,contenu) in resultJSON{
                            loginVar.setObject(contenu, forKey: key as! String)
                        }
                        loginVar.setInteger(1, forKey: "isLog")
                    }
                }catch _{
                    PopUp("La réponse n'est pas du JSON !")
                }
                //Si le code de la réponse n'est pas entre 200 et 300 alors il y a une erreur
            }else{
                PopUp("La base de donnée ne répond pas")
            }//fin test erreur HTTP
        }//fin test reponse
    })
    task.resume()
}