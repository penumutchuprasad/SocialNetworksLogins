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
import GoogleSignIn

class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate,GIDSignInDelegate {
   
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
        
        setupDefaultGoogleUI()
        
        if FBSDKAccessToken.current() != nil {
            print("User alredy logged-in")
//            print(FBSDKAccessToken.current().tokenString)
        }

    }
    
    func setupDefaultGoogleUI() {
        
        let googleLoginButton = GIDSignInButton.init()
        googleLoginButton.frame = CGRect(x: 16, y: 300, width: view.frame.width - 32, height: 50)
        
        view.addSubview(googleLoginButton)
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
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
    
    @IBAction func onCustomGoogleSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    @IBAction func onGoogleSignOutpressed(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance().signOut()
    }
    
    

    //Google Sign In
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
            
            print(userId ?? "")
            print(idToken ?? "")
            print(fullName ?? "")
            print(givenName ?? "")
            print(familyName ?? "")
            print(email ?? "@com")
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnected by user")
    }
    
    
    //UIDelegate Protocol
    
    
    

}

