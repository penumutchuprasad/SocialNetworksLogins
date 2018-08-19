//UIViewController + Ext.swift
/*
 * SocialNetworksIntegration
 * Created by penumutchu.prasad@gmail.com on 19/08/18
 * Is a product created by abnboys
 * For the SocialNetworksIntegration in the SocialNetworksIntegration
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import UIKit


extension UIViewController {
    
    func showAlert(withTitle title: String, andWithMessage mesg: String) {
        
        let alertVC = UIAlertController.init(title: title, message: mesg, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        present(alertVC, animated: true, completion: nil)
    }
    
}
