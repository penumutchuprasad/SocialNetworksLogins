//ViewController.swift
/*
 * SocialNetworksIntegration
 * Created by penumutchu.prasad@gmail.com on 19/08/18
 * Is a product created by abnboys
 * For the  in the SocialNetworksIntegration
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/


//let loginButton = FBSDKLoginButton.init(type: .custom)
//loginButton.center = view.center
//loginButton.readPermissions = ["public_profile", "email"]
//view.addSubview(loginButton)
//if FBSDKAccessToken.current() != nil {
//    print("User alredy logged-in")
//}

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBSDKLoginButton.init(type: .custom)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.layer.masksToBounds = true
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        view.addSubview(loginButton)
        
        
        if FBSDKAccessToken.current() != nil {
            print("User alredy logged-in")
//            print(FBSDKAccessToken.current().tokenString)
        }

    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User did logout")
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print("Going to login")
        return true
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print("Login goes error")
            return
        }
        
       showDetails()
        
    }
    
    func showDetails() {
        
        //OnSuccssful
        //Show alert with access token
        
        let accessToken = FBSDKAccessToken.current()
        
        if let tokenString = accessToken?.tokenString {
            showAlert(withTitle: "FB Access Token", andWithMessage: tokenString)
        }
        
        FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "fb graph error")
                return
            }
            
            print(result!)
            
        }
        
    }
    
    @IBAction func onCustFBLogin(_ sender: UIButton) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            
            if error != nil {
                print("Cust FB login error")
                return
            }
            
            if let res = result {
                if res.isCancelled {
                    return
                }
                //print(res.token.tokenString)
                self.showDetails()
            }
            
        }
    }


}

